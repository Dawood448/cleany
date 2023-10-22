import 'package:cleany/auth/auth.dart';
import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/providers/cleaner_details_provider.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../screens/days/set_work_days.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  //const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    //manageRouting();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.4,
      // height: MediaQuery.of(context).size.width / 1.4,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 260,
              child: DrawerHeader(
                // padding: EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                  color: AppColors.appThemeColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(50)),
                        child: Image.asset('assets/images/blankimage.png')),
                    const SizedBox(height: 10),
                    for (int i = 0; i < cleanerProfile.details.length; i++)
                      Text(
                        '${cleanerProfile.details[i].profile.firstName} ${cleanerProfile.details[i].profile.lastName}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                     Text(
                      'Cleaner'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              leading: const Icon(Icons.account_circle),
              title:  Text('Profile'.tr),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.workingCalender);
              },
              leading: const Icon(Icons.calendar_today_rounded),
              title:  Text('Working Calendar'.tr),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetWorkDays(), //pass any arguments
                        settings: const RouteSettings(name: AppRoutes.setWorkDays)));
                // Navigator.pushNamed(context, AppRoutes.setWorkDays);
              },
              leading: const Icon(Icons.work_off_outlined),
              title:  Text('Set Work Days'.tr),
            ),
            ListTile(
              onTap: () {
                Authentication.signOut();
                Navigator.pushNamed(context, '/');
              },
              leading: const Icon(Icons.arrow_back),
              title:  Text('Sign Out'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
