import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/providers/cleaner_details_provider.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    Widget defVerSpaceSet = getVerSpace(FetchPixels.getPixelHeight(20));
    Widget defDividerSet = getDivider(dividerColor, 0, 1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      bottomNavigationBar: editProfileButton(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [getVerSpace(FetchPixels.getPixelHeight(20)), buildHeader(context), buildExpandList(context, defVerSpaceSet, defDividerSet)],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return gettoolbarMenu(context, 'back.svg', () {
      Constant.backToPrev(context);
    }, istext: true, title: 'My Profile'.tr, weight: FontWeight.w900, fontsize: 24, textColor: Colors.black);
  }

  Expanded buildExpandList(BuildContext context, Widget defVerSpaceSet, Widget defDividerSet) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    return Expanded(
      flex: 1,
      child: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          // getVerSpace(FetchPixels.getPixelHeight(40)),
          profilePicture(context),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getCustomFont('Name'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            '${cleanerProfile.details.first.profile.firstName} ${cleanerProfile.details.first.profile.lastName}',
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Email'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].email,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Phone #'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.phoneNumber,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Status'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.status,
            16,
            Colors.green,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Role'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.role,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Gender'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.gender,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Language'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.language,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Zip Code'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.zipCode,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defDividerSet,
          defVerSpaceSet,
          getCustomFont('Address'.tr, 16, textColor, 1, fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont(
            cleanerProfile.details[0].profile.address,
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          defVerSpaceSet,
          defVerSpaceSet,
        ],
      ),
    );
  }

  Align profilePicture(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: FetchPixels.getPixelHeight(200),
        width: FetchPixels.getPixelHeight(200),
        child: cleanerProfile.details.isNotEmpty
            ? cleanerProfile.details.first.profile.gender.toLowerCase() == 'male'
                ? Lottie.asset('assets/images/male.json')
                : Lottie.asset('assets/images/female.json')
            : Image.network('assets/images/profile_image.png'),
      ),
    );
  }

  Container editProfileButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(20), right: FetchPixels.getPixelWidth(20), bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, blueColor, 'Edit Profile'.tr, Colors.white, () {
        Navigator.of(context).pushNamed(AppRoutes.edit);
      }, 18, weight: FontWeight.w600, buttonHeight: FetchPixels.getPixelHeight(60), borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }

  Widget _profile() {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: AppColors.appThemeColor),
          child: Column(
            children: [
              Container(
                color: AppColors.appThemeColor,
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Profile',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: cleanerProfile.details.first.profile.profilePicture == null
                            ? Container(
                                color: Colors.grey,
                                child: const Center(
                                  child: Text(
                                    'Not AvailAble',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                              )
                            : Container(
                                color: Colors.black,
                                child: Image.network(
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, object, stacktrace) {
                                    debugPrint('object : ${object.toString()}');
                                    debugPrint('stacktrace : ${stacktrace.toString()}');
                                    return const Text('Error');
                                  },
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${cleanerProfile.details.first.profile.firstName} ${cleanerProfile.details[0].profile.lastName}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Status',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cleanerProfile.details[0].profile.status,
                                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Role',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cleanerProfile.details[0].profile.role,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cleanerProfile.details[0].profile.gender,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Language',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cleanerProfile.details[0].profile.language,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Phone No',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cleanerProfile.details[0].profile.phoneNumber,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'ZipCode',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cleanerProfile.details[0].profile.zipCode,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Address',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      cleanerProfile.details[0].profile.address,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
