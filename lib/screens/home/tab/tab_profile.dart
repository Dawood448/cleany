import 'package:cleany/screens/home/tab/tab_review.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../base/color_data.dart';
import '../../../auth/auth.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../providers/cleaner_details_provider.dart';

class TabProfile extends StatefulWidget {
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {

  final Uri url = Uri.parse('https://bookcleany.com');
  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return SafeArea(
      child: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(20)),
          buildHeader(),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          buildExpand(context),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            child: buildButtonLogout(context),
          ),
        ],
      ),
    );
  }

  Widget buildButtonLogout(BuildContext context) {
    return getButton(context, blueColor, 'Logout'.tr, Colors.white, () {
      Authentication.signOut();
      Navigator.pushNamed(context, '/');
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
  }

  Expanded buildExpand(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);

    return Expanded(
      flex: 1,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpace(context),
        ),
        children: [
          SizedBox(
            height: FetchPixels.getPixelHeight(150),
            width: FetchPixels.getPixelHeight(150),
            child: cleanerProfile.details.isNotEmpty
                ? cleanerProfile.details.first.profile.gender.toLowerCase() ==
                        'male'
                    ? Lottie.asset('assets/images/male.json')
                    : Lottie.asset('assets/images/female.json')
                : Image.asset('assets/images/profile_image.png'),
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context,
              Colors.white,
              'My Profile'.tr,
              Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.profile),
              16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'user.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context,
              Colors.white,
              'Working Calender'.tr,
              Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.workingCalender),
              16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'calender.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context,
              Colors.white,
              'Set Work days'.tr,
              Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.setWorkDays),
              16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'clock.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context,
              Colors.white,
              'Privacy Policy'.tr,
              Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.privacy),
              16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'privacy.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(
              context,
              Colors.white,
              'Terms of Use'.tr,
              Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.terms),
              16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'termuse.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(context, Colors.white, 'Support'.tr, Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.support), 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'headphone.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(context, Colors.white, 'Report'.tr, Colors.black,
              () => Navigator.pushNamed(context, AppRoutes.report), 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'documnet.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),

          getButtonWithIcon(context, Colors.white, 'Learning & Resources'.tr,
              Colors.black, () => _launchInWebView(url), 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'documnet.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(20)),

          getButtonWithIcon(
              context,
              Colors.white,
              'Reviews'.tr,
              Colors.black,
                  () => Get.to(const TabReview()),
              16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
              BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: 'review.svg',
              sufixIcon: true,
              suffixImage: 'arrow_right.svg'),
          getVerSpace(FetchPixels.getPixelHeight(40)),


        ],
      ),
    );
  }

  Align buildHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: getCustomFont('Profile'.tr, 24, Colors.black, 1,
          fontWeight: FontWeight.w900),
    );
  }
}
