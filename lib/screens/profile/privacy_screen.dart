import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/color_data.dart';
import '../../../base/constant.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
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
                  buildToolbar(context),
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

  Expanded buildDetailTexts() {
    return Expanded(
      flex: 1,
      child: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          getMultilineCustomFont(
              '''At Bookcleany, we respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose information when you use our mobile application.

Information We Collect:
Personal Information: When you sign up for Bookcleany, we collect your name, email address, and phone number. We also collect your location information to match you with cleaning jobs near you.
Usage Information: We collect information about how you use our application, such as the pages you view, the dates and times of your visits, and the actions you take.

How We Use Your Information:
To provide you with cleaning job opportunities that match your location and skill set.
To communicate with you regarding your account, bookings, and other important information.
To improve our application and services.

Disclosure of Your Information:
We may disclose your information to our partners and affiliates, as well as third-party service providers who help us operate our application and provide our services.

Security:
We take the security of your personal information seriously and use industry-standard security measures to protect your data.

Changes to This Policy:
We reserve the right to update this Privacy Policy at any time. We will notify you of any changes by posting the updated policy on our website.'''.tr,
              16,
              Colors.black,
              fontWeight: FontWeight.w400,
              txtHeight: 1.3)
        ],
      ),
    );
  }

  Widget buildToolbar(BuildContext context) {
    return gettoolbarMenu(context, 'back.svg', () {
      Constant.backToPrev(context);
    },
        istext: true,
        title: 'Privacy Policy'.tr,
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }
}
