import 'dart:async';
import 'package:cleany/auth/auth.dart';
import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/constants/stat_variables.dart';
import 'package:cleany/providers/chatting_details_provider.dart';
import 'package:cleany/providers/chatting_list_provider.dart';
import 'package:cleany/providers/cleaner_details_provider.dart';
import 'package:cleany/providers/leave_list_provider.dart';
import 'package:cleany/providers/notification_list_provider.dart';
import 'package:cleany/screens/authentication/login_screen.dart';
import 'package:cleany/screens/home/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void callProviders() {
    final cleanerProfile =
        Provider.of<CleanerDetailsProvider>(context, listen: false);
    cleanerProfile.getDetails(context);

    setState(() {
      for (int i = 0; i < cleanerProfile.details.length; i++)
        StatVariables.userId =
            cleanerProfile.details[i].profile.user.toString();
    });

    final chattingList =
        Provider.of<ChattingListProvider>(context, listen: false);
    chattingList.getDetails(context);
    debugPrint(chattingList.list.toString());

    final chatDetails = Provider.of<ChatRoomProvider>(
      context,
      listen: false,
    );
    // _chatDetails.getDetails(context, roomId);

    final leaveDetails = Provider.of<LeaveListProvider>(context, listen: false);
    leaveDetails.getDetails(context);

    final notificationDetails =
        Provider.of<NotificationListProvider>(context, listen: false);
    notificationDetails.getDetails(context);
  }

  bool isLoggedIn = false;
  checkLogIn() async {
    var checkToken = await Authentication.token();

    if (checkToken != 'null') {
      debugPrint(checkToken.toString());
      setState(() {
        isLoggedIn = true;
        callProviders();
      });
      isLoggedIn
          ? Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Navbar(),
              ),
            )
          : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
    } else {
      setState(() {
        isLoggedIn = false;
      });
      Timer(
        const Duration(seconds: 1),
        () => isLoggedIn
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Navbar(),
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogIn();
    callProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      child: Center(
        child: Lottie.asset('assets/images/animation_Loading.json',
            frameRate: FrameRate(100), height: Get.height * 0.2),
      ),
    );
  }
}
