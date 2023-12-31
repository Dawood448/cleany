import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/providers/notification_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../variables/app_routes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var apis = ApiRequests();

  Future<void> getTokens(String token) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: 'jwt', value: token.toString());

    var getToken = await storage.read(key: 'jwt');

    debugPrint(getToken.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getNotification = Provider.of<NotificationListProvider>(context);
    FetchPixels(context);
    // return _notifications();
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backGroundColor,
        body: SafeArea(
          child: Column(
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
                child: buildSearchWidget(context),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getNotification.list.isEmpty ? nullListView(context) : notificationList()
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Constant.backToPrev(context);
        return false;
      },
    );
  }

  Widget buildSearchWidget(BuildContext context) {
    return gettoolbarMenu(context, 'back.svg', () {
      Constant.backToPrev(context);
    }, istext: true, title: 'Notifications'.tr, weight: FontWeight.w900, fontsize: 24, textColor: Colors.black);
  }

  Expanded notificationList() {
    final getNotification = Provider.of<NotificationListProvider>(context);
    return Expanded(
      flex: 1,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        itemCount: getNotification.list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
            padding: EdgeInsets.only(
                top: FetchPixels.getPixelHeight(20),
                bottom: FetchPixels.getPixelHeight(20),
                right: FetchPixels.getPixelWidth(20),
                left: FetchPixels.getPixelWidth(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(50),
                  width: FetchPixels.getPixelHeight(50),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE4ECFF),
                      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
                  padding: EdgeInsets.all(FetchPixels.getPixelHeight(13)),
                  child: getSvgImage('clock.svg'),
                ),
                getHorSpace(FetchPixels.getPixelWidth(14)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: getCustomFont(
                              getNotification.list[index].data![index].title ?? '',
                              16,
                              Colors.black,
                              1,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          getCustomFont(
                              timeago.format(
                                  DateTime.tryParse(
                                          getNotification.list[index].data![index].updatedAt ?? '') ??
                                      DateTime.now(),
                                  locale: 'en_short'),
                              14,
                              textColor,
                              1,
                              fontWeight: FontWeight.w400)
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(7)),
                      getCustomFont(
                        'New booking available ${getNotification.list[index].data![index].user!.userProfile!.firstName} ${getNotification.list[index].data![index].user!.userProfile!.lastName}',
                        16,
                        Colors.black,
                        2,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded nullListView(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: FetchPixels.getPixelHeight(124),
          width: FetchPixels.getPixelHeight(124),
          decoration: BoxDecoration(
            image: getDecorationAssetImage(context, 'bell.png'),
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getCustomFont('No Notifications Yet!'.tr, 20, Colors.black, 1, fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          'We’ll notify you when something arrives.'.tr,
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        )
      ],
    ));
  }

  Widget _notifications() {
    final getNotification = Provider.of<NotificationListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appThemeColor,
        title:  Text('Notifications'.tr),
      ),
      body: Center(
        child: MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => NotificationListProvider())],
          child: ListView.builder(
              itemCount: getNotification.list.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: ObjectKey(getNotification.list[index].data!.elementAt(index)),
                  onDismissed: (direction) {
                    setState(() {
                      getNotification.list[index].data!.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Deleted'.tr)));
                    });
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.customerDetails);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 3.0,
                        child: ListTile(
                          leading: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Icon(Icons.notifications_active_outlined)],
                          ),
                          title: Text(getNotification.list[index].data![index].title.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            'New Booking available ${getNotification.list[index].data![index].user!.userProfile!.firstName} ${getNotification.list[index].data![index].user!.userProfile!.lastName}',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
