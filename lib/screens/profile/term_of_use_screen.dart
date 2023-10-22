import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              'terms and conditions'.tr,
              16,
              Colors.black,
              fontWeight: FontWeight.w400,
              txtHeight: 1.3)
        ],
      ),
    );
  }
}
