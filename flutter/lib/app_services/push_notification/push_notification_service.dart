import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  BigPictureStyleInformation? bigPictureStyleInformation;


  late AndroidNotificationChannel channel;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  init() async {
    // Set the background messaging handler early on, as a named top-level function
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications',// title
        importance: Importance.high,description:'High Importance Description', // description

      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        if (message.notification?.android?.imageUrl != null) {
          final http.Response response = await http
              .get(Uri.parse(message.notification!.android!.imageUrl!));
          bigPictureStyleInformation = BigPictureStyleInformation(
              ByteArrayAndroidBitmap.fromBase64String(
                  base64Encode(response.bodyBytes)),
              hideExpandedLargeIcon: true);
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription:channel.description,
                playSound: true,
                icon: 'launch_background',
                largeIcon: ByteArrayAndroidBitmap(response.bodyBytes),
                styleInformation: bigPictureStyleInformation,
              ),
            ),
          );
        } else {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription:channel.description,
                icon: 'launch_background',
              ),
            ),
          );
        }
      }
    });
  }
}
