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
              'privacy and policy'.tr,
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
