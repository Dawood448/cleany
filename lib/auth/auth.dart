import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authentication {
  static token() async {
    const storage = FlutterSecureStorage();
    var getToken = await storage.read(key: 'jwt');

    return getToken.toString();
  }

  static userId() async {
    const storage = FlutterSecureStorage();
    var userid = await storage.read(key: 'userid');

    return userid.toString();
  }

  static signOut() async {
    const storage = FlutterSecureStorage();
    storage.delete(key: 'jwt');
    FirebaseMessaging.instance.unsubscribeFromTopic('cleany_${userId()}');

    storage.delete(key: 'userid');
  }
}
