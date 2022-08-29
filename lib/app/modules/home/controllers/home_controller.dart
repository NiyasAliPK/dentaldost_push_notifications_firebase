import 'package:dentaldost/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    firebaseOnMessage();
    firebaseOnOpenApp();

    super.onInit();
  }

  firebaseOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification!;
      AndroidNotification? android = message.notification!.android;

      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    icon: '@mipmap/ic_launcher',
                    playSound: true)));
      }
    });
  }

  firebaseOnOpenApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;
      if (android != null) {
        Get.defaultDialog(
            title: notification.title.toString(),
            content: Column(children: [Text(notification.body.toString())]));
      }
    });
  }

  showNotifiations() {
    flutterLocalNotificationsPlugin.show(
        channel.hashCode,
        'testing notifications',
        'Hello DenatalDost user',
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        )));
  }
}
