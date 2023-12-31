import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../base/color_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../notification_service/local_notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String deviceTokenToSendPushNotification = '';

  @override
  void initState() {
    super.initState();
    LocalNotificationService().setupNotification();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({'token_id': deviceTokenToSendPushNotification})
        .then((value) => debugPrint('User Added'))
        .catchError((error) => debugPrint('Failed to add user: $error'));
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    addUser();
    FetchPixels(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
              )
            ],
            image: const DecorationImage(
              image: AssetImage("assets/images/splash_background.jpg"),
              fit: BoxFit.cover,
              opacity: 0.6,
            ),
          ),
          child: Center(
              child: getAssetImage(
                  'splash.png',
                  FetchPixels.getPixelHeight(180),
                  FetchPixels.getPixelHeight(180))),
        ),
      ),
    );
  }
}
