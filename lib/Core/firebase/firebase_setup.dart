import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/Core/firebase/firebase_api.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDQb0_ZWW6fZiXRmXb2zT3qIC_roNZU160",
      appId: "1:720522902975:android:073a47867c0697f71fb50a",
      messagingSenderId: "720522902975",
      projectId: "iraqpalm-d9c2d",
    ),
  );
  await FirebaseApi().inintNotifications();
  await FirebaseMessaging.instance.subscribeToTopic("general");
}
