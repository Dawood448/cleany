import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class NoInternetInitial extends StatefulWidget {
  final Function checkInternetAccess;

  const NoInternetInitial({
    Key? key,
    required this.checkInternetAccess,
  }) : super(key: key);

  @override
  State<NoInternetInitial> createState() => _NoInternetInitialState();
}

class _NoInternetInitialState extends State<NoInternetInitial> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
          child: buildList(context),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return Column(
      children: [
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getAssetImage('logo.png', 100, 100),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getCustomFont('No internet connection available'.tr, 24, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        const Spacer(),
        buildButton(context),
        getVerSpace(FetchPixels.getPixelHeight(70)),
      ],
    );
  }

  Widget buildButton(BuildContext context) {
    return getButton(context, blueColor, 'Refresh'.tr, Colors.white, () async {
      await widget.checkInternetAccess();
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)));
  }

  Widget _noInternet() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: 40.0,
          width: double.maxFinite,
        ),
      ),
      body: Container(
        color: Colors.blueGrey,
        width: double.maxFinite,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(
              height: 220,
              child: Text(
                'No Internet Connection'.tr,
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                'No Internet'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ButtonTheme(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0.1,
                  ),
                  onPressed: () async {
                    await widget.checkInternetAccess();
                  },
                  child:  Text('Refresh'.tr),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
