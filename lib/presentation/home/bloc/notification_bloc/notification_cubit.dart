import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit {
  NotificationCubit() : super(null);

  void getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final user = FirebaseAuth.instance.currentUser;

    NotificationSettings setting = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    messaging.getToken().then((token) {
      print('Token; ${token}');

      FirebaseFirestore.instance
          .collection('User')
          .doc(user!.uid)
          .update({'fcmToken': token});
    });
  }
}
