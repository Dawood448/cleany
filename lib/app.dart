import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'apis/request_apis.dart';
import 'language/languages.dart';
import 'providers/booking_list_provider.dart';
import 'providers/chatting_details_provider.dart';
import 'providers/chatting_list_provider.dart';
import 'providers/cleaner_details_provider.dart';
import 'providers/leave_list_provider.dart';
import 'providers/notification_list_provider.dart';
import 'routes/routes.dart';
import 'screens/core/no_internet_initial.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    _checkInternetAccess();
  }

  bool _hasInternetConnection = true;

  void _checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        setState(() {
          _hasInternetConnection = true;
        });
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
      setState(() {
        _hasInternetConnection = false;
      });
    }
  }

  int counter = 0;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    debugPrint(Geolocator.getCurrentPosition().toString());

    return await Geolocator.getCurrentPosition();
  }

  void getLocation() async {
    counter++;
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Timer.periodic(const Duration(minutes: 10), (Timer t) async {
      counter++;
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      debugPrint(position.toString());
      ApiRequests()
          .pushLocation('${position.latitude}', ' ${position.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    _determinePosition();

    // Timer.periodic(Duration(seconds: 30), (Timer t) => getLocation());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: const Locale('en','US'),
      home: _hasInternetConnection
          ? MultiProvider(
              providers: [
                ChangeNotifierProvider<CleanerDetailsProvider>(
                    create: (_) => CleanerDetailsProvider()),
                ChangeNotifierProvider<BookingListProvider>(
                    create: (_) => BookingListProvider()),
                ChangeNotifierProvider<ChatRoomProvider>(
                    create: (_) => ChatRoomProvider()),
                ChangeNotifierProvider<ChattingListProvider>(
                    create: (_) => ChattingListProvider()),
                // ChangeNotifierProvider<GetBranchesProvider>(
                //     create: (_) => GetBranchesProvider()),
                ChangeNotifierProvider<LeaveListProvider>(
                    create: (_) => LeaveListProvider()),
                ChangeNotifierProvider<NotificationListProvider>(
                    create: (_) => NotificationListProvider()),
              ],
              child: const Routes(),
            )
          : NoInternetInitial(checkInternetAccess: _checkInternetAccess),
    );
  }
}
