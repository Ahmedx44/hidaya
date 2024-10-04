import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hidaya/main.dart';
import 'package:hidaya/presentation/chat/page/chat_list.dart';

Future<void> handleBackgroundNotification(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class NotificationCubit extends Cubit<void> {
  NotificationCubit() : super(null);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high-importance_channel',
    'High Importance Notification',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();

  void initNotification() async {
    // Request notification permissions
    NotificationSettings setting = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    // Retrieve FCM token
    messaging.getToken().then((token) {
      print('FCM Token: $token');
      registerToken(token);
      initPushNotification();
      initLocalNotification();
    });
  }

  void registerToken(String? token) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .update({'fcmToken': token});
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Navigate to the chat list page on message tap
    navigatorKey.currentState
        ?.pushNamed(ChatListPage.route, arguments: message);
  }

  Future<void> initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        // Handle payload when user taps on the notification
        if (notificationResponse.payload != null) {
          final Map<String, dynamic> data =
              jsonDecode(notificationResponse.payload!);

          final message = RemoteMessage.fromMap(data);

          // Custom handler for the message
          handleMessage(message);
        }
      },
    );

    // Create Android notification channel
    final platform = _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initPushNotification() async {
    // Handle notifications when the app is in foreground
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // Handle messages that caused the app to be opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }
}
