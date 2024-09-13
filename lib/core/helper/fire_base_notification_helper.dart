import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseNotificationHelper {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    _firebaseMessaging.getToken().then((token) {
      log(token.toString());
    });

    handleBackgroundMessage();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future handleBackgroundMessage() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
