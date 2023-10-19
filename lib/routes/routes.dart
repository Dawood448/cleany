import 'package:cleany/screens/profile/privacy_screen.dart';
import 'package:cleany/screens/profile/report_screen.dart';
import 'package:cleany/screens/profile/support_screen.dart';
import 'package:cleany/screens/profile/term_of_use_screen.dart';
import 'package:flutter/material.dart';

import '../screens/authentication/forgot_screen.dart';
import '../screens/authentication/login_screen.dart';
import '../screens/booking/booking_details_screen.dart';
import '../screens/core/loading_screen.dart';
import '../screens/days/set_work_days.dart';
import '../screens/days/working_calendar.dart';
import '../screens/home/navbar.dart';
import '../screens/home/tab/tab_bookings.dart';
import '../screens/home/tab/tab_chat.dart';
import '../screens/home/tab/tab_profile.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../variables/app_routes.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cleany App',
      initialRoute: AppRoutes.splash,
      routes: {
        '/': (context) => const LoadingScreen(),
        AppRoutes.navbar: (context) => const Navbar(),
        AppRoutes.tabProfile: (context) => const TabProfile(),
        AppRoutes.dashboard: (context) => const TabBookings(),
        AppRoutes.loading: (context) => const LoadingScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.forgot: (context) => const ForgotScreen(),
        AppRoutes.customerDetails: (context) => BookingDetailsScreen(shiftStarted: true, index: 0),
        AppRoutes.edit: (context) => const EditScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.privacy: (context) => const PrivacyScreen(),
        AppRoutes.terms: (context) => const TermOfUseScreen(),
        AppRoutes.support: (context) => const SupportScreen(),
        AppRoutes.report: (context) => const ReportScreen(),
        AppRoutes.notifications: (context) => const NotificationScreen(),
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.workingCalender: (context) => const Calendar(),
        AppRoutes.setWorkDays: (context) => const SetWorkDays(),
        AppRoutes.chatList: (context) => const TabChat(),
      },
    );
  }
}
