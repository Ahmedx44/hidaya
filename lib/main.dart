import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/common/bloc/theme_cubit.dart';
import 'package:hidaya/core/config/assets/theme/app_theme.dart';
import 'package:hidaya/firebase_options.dart';
import 'package:hidaya/presentation/auth/pages/authgate.dart';
import 'package:hidaya/presentation/chat/page/chat_list.dart';
import 'package:hidaya/presentation/home/bloc/notification_bloc/notification_cubit.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/surah_state_cubit.dart';
import 'package:hidaya/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_flutter/quran.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializedDependency();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  FirebaseMessaging.instance.getToken().then((token) {
    print('FCM Token: $token');
  });

  await Quran.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseMessaging firemessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => SurahCubit()),
          BlocProvider(create: (_) => NotificationCubit())
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, theme) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              routes: {
                ChatListPage.route: (context) => const ChatListPage(),
                // Other routes
              },
              debugShowCheckedModeBanner: false,
              themeMode: theme,
              theme: lightMode,
              darkTheme: darkMode,
              home: const AuthGate(),
            );
          },
        ),
      ),
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hidaya/common/bloc/theme_cubit.dart';
// import 'package:hidaya/core/config/assets/theme/app_theme.dart';
// import 'package:hidaya/firebase_options.dart';
// import 'package:hidaya/presentation/auth/pages/authgate.dart';
// import 'package:hidaya/presentation/quran_surah_list/Bloc/surah_state_cubit.dart';
// import 'package:hidaya/service_locator.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:quran_flutter/quran.dart';

// // Initialize the FlutterLocalNotificationsPlugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // Initialize dependency injection
//   await initializedDependency();

//   // Set up storage for hydrated_bloc
//   HydratedBloc.storage = await HydratedStorage.build(
//     storageDirectory: kIsWeb
//         ? HydratedStorage.webStorageDirectory
//         : await getApplicationDocumentsDirectory(),
//   );

//   // Initialize Quran
//   await Quran.initialize();

//   // Initialize notifications
//   await initializeNotifications();

//   runApp(const MyApp());
// }

// Future<void> initializeNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings(
//           '@mipmap/ic_launcher'); // Update to your app icon

//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }

// // Background message handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handling a background message: ${message.messageId}');
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   FirebaseMessaging firemessaging = FirebaseMessaging.instance;

//   void requestPermission() async {
//     NotificationSettings settings = await firemessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     final fireToken = await firemessaging.getToken();
//     print('Firebase Messaging Token: $fireToken');
//   }

//   void setupFirebaseMessaging() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Message received: ${message.notification?.title}');
//       if (message.notification != null) {
//         showNotification(
//             message.notification?.title, message.notification?.body);
//       }
//     });
//   }

//   void showNotification(String? title, String? body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'channel_id', // Channel ID
//       'Chat Notifications', // Channel name

//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x', // Payload can be used to handle click action
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     requestPermission();
//     setupFirebaseMessaging();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FirebasePhoneAuthProvider(
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (_) => ThemeCubit()),
//           BlocProvider(create: (_) => SurahCubit()),
//         ],
//         child: BlocBuilder<ThemeCubit, ThemeMode>(
//           builder: (context, theme) {
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               themeMode: theme,
//               theme: lightMode,
//               darkTheme: darkMode,
//               home: const AuthGate(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
