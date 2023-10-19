import 'package:flutter/material.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/widget_utils.dart';
import '../../base/resizer/fetch_pixels.dart';

class TermOfUseScreen extends StatefulWidget {
  const TermOfUseScreen({Key? key}) : super(key: key);

  @override
  State<TermOfUseScreen> createState() => _TermOfUseScreenState();
}

class _TermOfUseScreenState extends State<TermOfUseScreen> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  buildHeader(context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  buildDetailTexts()
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Widget buildHeader(BuildContext context) {
    return gettoolbarMenu(context, 'back.svg', () {
      Constant.backToPrev(context);
    },
        istext: true,
        title: 'Terms of Use',
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }

  Expanded buildDetailTexts() {
    return Expanded(
      flex: 1,
      child: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          getMultilineCustomFont(
              '''Welcome to Bookcleany! By using our mobile application, you agree to be bound by the following Terms of Use:

Booking Process:

Bookings: We match you with cleaning job opportunities based on your location and skill set. Once you accept a job, you are responsible for completing it in a timely and professional manner.
Payment: You will be paid for your completed jobs on a weekly basis. Bookcleany charges a small commission for each job completed.
Your Responsibilities:

Professionalism: You are expected to act in a professional manner when interacting with clients and other users of our application.
Safety: You are responsible for ensuring your own safety and the safety of others while completing cleaning jobs.
Ratings and Reviews: Clients may rate and review your performance after each job. Your ratings and reviews will be visible to other clients.
Prohibited Activities:

Fraud: You may not engage in any fraudulent activity while using our application.
Harassment: You may not harass or discriminate against other users of our application.
Illegal Activities: You may not use our application to engage in any illegal activities.
Intellectual Property:
All content and materials on our application, including but not limited to logos, text, images, and software, are the property of Bookcleany and are protected by copyright and other intellectual property laws.

Termination:
We reserve the right to terminate your account if you violate any of our Terms of Use.''',
              16,
              Colors.black,
              fontWeight: FontWeight.w400,
              txtHeight: 1.3)
        ],
      ),
    );
  }
}
