import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

Future<void> kOverlayWithAsync({required Function asyncFunction}) async {
  await Get.showOverlay(
    opacity: 0.8,
    opacityColor: Colors.white,
    loadingWidget: const LoadingWidget(),
    asyncFunction: () async => await asyncFunction(),
  );
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.height = 150});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      child: Center(
        child: Lottie.asset('assets/images/Animation - 1703700124666.json',
            frameRate: FrameRate(100), height: height),
      ),
    );
  }
}
