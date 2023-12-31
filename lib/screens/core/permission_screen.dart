import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/screens/home/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 710,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/permission_picture.png',
                        ),
                        fit: BoxFit.fill)),
              ),
              Positioned(
                top: 400,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.appThemeColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Text(
                        'Cleaning On Demand'.tr,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Column(
                        children:  [
                          Text(
                            'Book an apointment in'.tr,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text('less then 60 seconds and get on'.tr,
                              style: const TextStyle(color: Colors.white, fontSize: 20)),
                          Text('the schedule as early as'.tr,
                              style: const TextStyle(color: Colors.white, fontSize: 20)),
                          Text('tommorrow'.tr, style: const TextStyle(color: Colors.white, fontSize: 20))
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              'Skip'.tr,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                 Text(
                                  'Next'.tr,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Navbar()),
                                        (route) => false);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.yellowColor,
                                        borderRadius: BorderRadius.circular(40)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.white,
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
              )
            ]),
          ],
        ),
      ),
    );
  }
}
