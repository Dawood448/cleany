import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/booking/booking_details_screen.dart';
import '../screens/chats/admin_chat_screen.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<String?> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Initialization settings for Android
    InitializationSettings initializationSettings = const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        ),
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        Map<String, dynamic> data = {'booking_id': response.payload};
        LocalNotificationService().navigation(data);
      },
    );
    // Retrieve FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('Firebase Cloud Messaging token: $fcmToken');
    }
    prefs.setString('fcmtoken', fcmToken!);
    return fcmToken;
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'pushnotificationapp',
          'pushnotificationappchannel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['booking_id'],
      );
      debugPrint('OKOKOKOKOKOKOKOKOK');
    } on Exception catch (e) {
      debugPrint('QUITTTTTTTTTTTTTTTTT');
      debugPrint(e.toString());
    }
  }

  void setupNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        // navigate();
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if ( message.notification != null) {
        LocalNotificationService.createAndDisplayNotification(message);
      }
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('message data: ${message.notification!.title}');
        print('message data: ${message.notification!.body}');
        print('message data: ${jsonEncode(message.data)}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('Got a message whilst in the background!');
        print('message data: ${message.notification!.title}');
        print('message data: ${message.notification!.body}');
        print('message data: ${message.data}');
      }
      navigation(message.data);
    });
  }

  Future<void> navigation(Map<String, dynamic> payload) async {
    try {
      if (payload['booking_id'] != '') {
          Get.to(BookingDetailsScreen(
            index: 0,
            booking: payload['booking_id'], shiftStarted: false,
          ));
        }
       else if (payload['booking_id'] == '') {
        Get.to(const AdminChatsScreen());
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

}





