import 'dart:core';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();

    //_firebaseMessaging.getInitialMessage();

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("${message.notification?.title}");
      print("${message.notification?.body}");
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // int id = int.parse(message.data["id"]);

    // if (id != 0) {
    //   print(id);
    //   navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
    // }
    //   print(message);
    // });

    // _firebaseMessaging
    //     .getInitialMessage()
    //     .then((RemoteMessage? initialMessage) {
    //   int id = int.parse(initialMessage?.data["id"]);

    //   if (id != 0) {
    //     HelperFireBase.checker = false;

    //     navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
    //   }
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   int id = int.parse(message.data["id"]);
    //   if (id != 0) {
    //     navigatorKey.currentState!.pushNamed(NewsMainPage.rn, arguments: id);
    //   }
    // });
  }
}
