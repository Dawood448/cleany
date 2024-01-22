import 'package:cleany/widgets/language_dailoge.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'notification_service/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  debugPrint(message.notification!.title);
}

Future<void> init() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? savedLanguageCode = prefs.getString('languageCode');
  final String? savedCountryCode = prefs.getString('countryCode');
  if (savedLanguageCode != null && savedCountryCode != null) {
    currentLocale.value = Locale(savedLanguageCode, savedCountryCode);
    Get.updateLocale(currentLocale.value);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await LocalNotificationService.initialize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
