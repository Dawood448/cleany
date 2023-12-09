import 'dart:developer';
import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/models/booking_details_model.dart';
import 'package:cleany/models/chat_room.dart';
import 'package:cleany/providers/booking_list_provider.dart';
import 'package:cleany/screens/chats/chats_screen.dart';
import 'package:cleany/screens/notification/notification_screen.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:cleany/variables/global_variables.dart';
import 'package:cleany/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../base/color_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../providers/cleaner_details_provider.dart';
import '../../../widgets/language_dailoge.dart';
import '../../booking/booking_details_screen.dart';
import 'tab_chat.dart';

class TabBookings extends StatefulWidget {
  const TabBookings({Key? key}) : super(key: key);

  @override
  State<TabBookings> createState() => _TabBookingsState();
}

class _TabBookingsState extends State<TabBookings> {
  final int _page = 0;

  List<BookingDetailsModel> pendingBookings = [];
  List<BookingDetailsModel> completedBookings = [];
  List<BookingDetailsModel> todayBookings = [];
  List<BookingDetailsModel> allBookings = [];

  var valDay = DateTime.now().day;
  var valMonth = DateTime.now().month;
  var valYear = DateTime.now().year;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print('initState');
    setState(() {
      final bookingsList =
          Provider.of<BookingListProvider>(context, listen: false);
      bookingsList
          .getDetails(context)
          .then((value) => taskAssign(bookingsList));
      // taskAssign(bookingsList);
    });

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    super.initState();
  }

  void taskAssign(BookingListProvider bookingsList) {
    debugPrint('Refreshed-----');

    allBookings.clear();
    todayBookings.clear();
    pendingBookings.clear();
    completedBookings.clear();
    // print(bookingsList.list.length);
    for (int i = 0; i < bookingsList.list.length; i++) {
      if (bookingsList.list[i].data![i].schedule!.createdAt!.day == valDay &&
          bookingsList.list[i].data![i].schedule!.createdAt!.month ==
              valMonth &&
          bookingsList.list[i].data![i].schedule!.createdAt!.year == valYear) {
        setState(() {
          todayBookings.add(bookingsList.list[i]);
        });
      }
    }

    for (int i = 0; i < bookingsList.list.length; i++) {
      if (bookingsList.list[i].data![i].schedule!.shiftStatus == 'pending') {
        pendingBookings.add(bookingsList.list[i]);
      }
      if (bookingsList.list[i].data![i].schedule!.shiftStatus == 'completed') {
        completedBookings.add(bookingsList.list[i]);
      }
    }

    setState(() {
      allBookings.addAll(bookingsList.list);
      debugPrint('Refreshed');
      // print(allBookings.length);
    });
  }

  final _timeFormat = DateFormat.jm();
  final _dateFormat = DateFormat('dd MMMM, yyyy');

  @override
  Widget build(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);

    FetchPixels(context);
    // return _dashboard();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: getCustomFont(
            (() {
              if (cleanerProfile.details.isNotEmpty) {
                print(cleanerProfile.details.first.profile.firstName);
                return '${cleanerProfile.details.first.profile.firstName} ${cleanerProfile.details.first.profile.lastName}';
              } else {
                return '';
              }
            })(),
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w400,
          ),
          // centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(46),
                  width: FetchPixels.getPixelHeight(46),
                  decoration: BoxDecoration(
                    image: getDecorationAssetImage(
                      context,
                      cleanerProfile.details.isNotEmpty
                          ? cleanerProfile.details.first.profile.gender
                                      .toLowerCase() ==
                                  'male'
                              ? 'male.png'
                              : 'female.png'
                          : 'profile_image.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  buildLanguageDialog(context);
                },
                icon: const Icon(
                  Icons.language,
                  size: 25,
                  color: Colors.black,
                )),
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.notifications);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: getSvgImage(
                  'notification_unselected.svg',
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24),
                ),
              ),
            )
          ],
        ),
        // body:
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // getVerSpace(FetchPixels.getPixelHeight(25)),
            // buildTopRow(context),
            getVerSpace(FetchPixels.getPixelHeight(25)),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: getCustomFont('Bookings'.tr, 18, Colors.black, 1,
                  fontWeight: FontWeight.w900),
            ),
            getVerSpace(FetchPixels.getPixelHeight(25)),
            Expanded(
              flex: 1,
              child: RefreshIndicator(
                onRefresh: () async {
                  final bookingsList =
                      Provider.of<BookingListProvider>(context, listen: false);
                  bookingsList
                      .getDetails(context)
                      .then((value) => taskAssign(bookingsList));
                  setState(() {});
                },
                child: Stack(
                  children: [
                    bookingList(),
                    // (allBookings.isEmpty) ? nullListView() : bookingList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTopRow(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: FetchPixels.getPixelHeight(46),
            width: FetchPixels.getPixelHeight(46),
            decoration: BoxDecoration(
              image: getDecorationAssetImage(
                context,
                cleanerProfile.details.isNotEmpty
                    ? cleanerProfile.details.first.profile.gender
                                .toLowerCase() ==
                            'male'
                        ? 'male.png'
                        : 'female.png'
                    : 'profile_image.png',
              ),
            ),
          ),
          getHorSpace(FetchPixels.getPixelWidth(12)),
          Expanded(
            flex: 1,
            child: getCustomFont(
              (() {
                if (cleanerProfile.details.isNotEmpty) {
                  return '${cleanerProfile.details.first.profile.firstName} ${cleanerProfile.details.first.profile.lastName}';
                } else {
                  return '';
                }
              })(),
              16,
              Colors.black,
              1,
              fontWeight: FontWeight.w400,
            ),
          ),
          IconButton(
              onPressed: () {
                buildLanguageDialog(context);
              },
              icon: const Icon(
                Icons.language,
                size: 25,
                color: Colors.black,
              )),
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.notifications);
            },
            child: getSvgImage(
              'notification_unselected.svg',
              height: FetchPixels.getPixelHeight(24),
              width: FetchPixels.getPixelHeight(24),
            ),
          )
        ],
      ),
    );
  }

  Widget nullListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSvgImage('booking_null.svg',
            height: FetchPixels.getPixelHeight(124),
            width: FetchPixels.getPixelHeight(84.77)),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getCustomFont('No Bookings Yet!'.tr, 20, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center)
      ],
    );
  }

  Widget bookingList() {
    return FutureBuilder<List<BookingDetailsModel>>(
      future: ApiRequests().getBookingetailsApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Error state
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<BookingDetailsModel> allBookings = snapshot.data!;

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getDefaultHorSpace(context),
            ),
            shrinkWrap: true,
            primary: true,
            itemCount: allBookings.length,
            itemBuilder: (context, index) {
              final booking = allBookings[index];
              return GestureDetector(
                child: buildBookingItem(booking.data![index]),
                onTap: () {
                  try {
                    final bookingData = booking.data![index];
                    if (bookingData.schedule?.shiftStatus == 'pending') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailsScreen(
                            shiftStarted: true,
                            booking: booking,
                            index: index,
                            servicesIndex: bookingData.packages?.length,
                            extraIndex: bookingData.extras?.length,
                          ),
                        ),
                      ).then((value) {
                        final bookingsList = Provider.of<BookingListProvider>(
                            context,
                            listen: false);
                        bookingsList
                            .getDetails(context)
                            .then((value) => taskAssign(bookingsList));
                        setState(() {});
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailsScreen(
                            shiftStarted: true,
                            booking: booking,
                            index: index,
                          ),
                        ),
                      ).then((value) {
                        final bookingsList = Provider.of<BookingListProvider>(
                            context,
                            listen: false);
                        bookingsList
                            .getDetails(context)
                            .then((value) => taskAssign(bookingsList));
                        setState(() {});
                      });
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                },
              );
            },
          );
        }
        return nullListView();
      },
    );
  }

  Widget buildBookingItem(BookingDetailsData? details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          height: 35,
          color: Colors.grey.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: Text(
              DateFormat('dd MMMM, yyyy').format(details!.appointmentDateTime!),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(12)),
        Container(
          margin: EdgeInsets.only(
            bottom: FetchPixels.getPixelHeight(20),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0.0, 4.0)),
            ],
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(16),
            vertical: FetchPixels.getPixelHeight(16),
          ),
          width: double.maxFinite,
          child: details == null
              ? Text(
                  'Something went wrong',
                  style: TextStyle(color: error, fontWeight: FontWeight.w700),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: FetchPixels.getPixelHeight(30),
                          backgroundColor: blueColor,
                          child: Hero(
                            tag: details.id.toString(),
                            child: getAssetImage(
                              'default_avatar.png',
                              FetchPixels.getPixelHeight(58),
                              FetchPixels.getPixelHeight(58),
                            ),
                          ),
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(12)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${details.bod?.bodContactInfo?.firstName ?? ''}\'s Place',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(5)),
                            Text(
                              'JOB ID# ${details.id ?? ''}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900),
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(5)),
                            Row(
                              children: [
                                const Text(
                                  'Service: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  details.service!.name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(5)),
                            Row(
                              children: [
                                const Text(
                                  'Start: ',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  _dateFormat.format(
                                      details.schedule?.startTime ??
                                          DateTime.now()),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(5)),
                            Row(
                              children: [
                                const Text(
                                  'From: ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '${_timeFormat.format(details.schedule?.startTime ?? DateTime.now())} to ${_timeFormat.format(details.schedule?.endTime ?? DateTime.now())}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(5)),
                            Row(
                              children: [
                                const Text(
                                  'Total Hours: ',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  '     ${details.totalHours.toString()}H' ??
                                      "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (details.schedule?.shiftStatus?.isNotEmpty ??
                            false) ...[
                          const Spacer(),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(
                              horizontal: FetchPixels.getPixelWidth(12),
                              vertical: FetchPixels.getPixelHeight(6),
                            ),
                            decoration: ShapeDecoration(
                              shape: const StadiumBorder(),
                              color: details.schedule?.shiftStatus == 'pending'
                                  ? error.withOpacity(0.2)
                                  : details.schedule?.shiftStatus == 'completed'
                                      ? completed.withOpacity(0.2)
                                      : success.withOpacity(0.2),
                            ),
                            child: Text(
                              GetStringUtils(details.schedule?.shiftStatus)
                                      ?.capitalize ??
                                  '',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: details.schedule?.shiftStatus ==
                                        'pending'.tr
                                    ? error
                                    : details.schedule?.shiftStatus ==
                                            'completed'.tr
                                        ? completed
                                        : success,
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(12)),
                    getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
                    getVerSpace(FetchPixels.getPixelHeight(12)),
                    Row(
                      children: [
                        getSvgImage('location.svg'),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        Expanded(
                          child: Text(
                            details.bod?.bodServiceLocation?.streetAddress ??
                                'N/A',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        if (details.schedule!.shiftStatus == 'pending' ||
                            details.schedule!.shiftStatus == 'completed') ...[
                          getHorSpace(FetchPixels.getPixelWidth(30)),
                          InkWell(
                            onTap: () {
                              if (details.schedule!.shiftStatus == 'pending') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatsScreen(
                                      bookingId: details.id,
                                    ),
                                  ),
                                );
                              } else if (details.schedule!.shiftStatus ==
                                  'completed') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatsScreen(
                                      bookingId: details.id,
                                    ),
                                  ),
                                );
                              }
                            },
                            customBorder: const CircleBorder(),
                            child: const Icon(CupertinoIcons.chat_bubble),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _dashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffold,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: AppColors.appThemeColor),
          child: Column(
            children: [
              Container(
                color: AppColors.appThemeColor,
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _scaffold.currentState!.openDrawer();
                                },
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'DASHBOARD'.tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen()));

                              Navigator.pushNamed(
                                  context, AppRoutes.notifications);
                            },
                            child: Image.asset(
                              'assets/images/notification.png',
                              height: 50,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _page == 0
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Today\'s Appointments'.tr,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                todayBookings.isNotEmpty
                                    ? MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create: (_) =>
                                                BookingListProvider(),
                                          )
                                        ],
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: todayBookings.isEmpty
                                                ? 0
                                                : todayBookings.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookingDetailsScreen(
                                                              shiftStarted:
                                                                  true,
                                                              booking:
                                                                  todayBookings[
                                                                      index],
                                                              index: index,
                                                            )),
                                                  );
                                                },
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  elevation: 3.0,
                                                  child: ListTile(
                                                    leading: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${todayBookings[index].data![index].schedule!.startTime!.hour}:${todayBookings[index].data![index].schedule!.startTime!.minute}-'),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            '${todayBookings[index].data![index].schedule!.endTime!.hour}:${todayBookings[index].data![index].schedule!.startTime!.minute}'),
                                                      ],
                                                    ),
                                                    trailing: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              // Navigator.push(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //       builder: (context) =>
                                                              //           ChatRoomScreen(
                                                              //               //user: null,
                                                              //               )),
                                                              // );
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .textsms_outlined,
                                                              color: Color(
                                                                  0xff206bc4),
                                                            )),
                                                      ],
                                                    ),
                                                    title: Text(
                                                        '${todayBookings[index].data![index].bod!.bodContactInfo!.firstName}\'s Place'),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(todayBookings[
                                                                        index]
                                                                    .data![
                                                                        index]
                                                                    .bod!
                                                                    .additionalInfo
                                                                    .toString() ==
                                                                ''
                                                            ? 'No additional information provided'
                                                            : todayBookings[
                                                                    index]
                                                                .data![index]
                                                                .bod!
                                                                .additionalInfo
                                                                .toString()),
                                                        Text(
                                                            '${todayBookings[index].data![index].bod!.bodServiceLocation!.streetAddress}, ${todayBookings[index].data![index].bod!.bodServiceLocation!.city}'),
                                                      ],
                                                    ),
                                                    isThreeLine: true,
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : Center(
                                        child: Text(
                                          'No appointments today'.tr,
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  'Pending Appointments'.tr,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                pendingBookings.isNotEmpty
                                    ? MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create: (_) =>
                                                BookingListProvider(),
                                          )
                                        ],
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: pendingBookings.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookingDetailsScreen(
                                                              shiftStarted:
                                                                  true,
                                                              booking:
                                                                  pendingBookings[
                                                                      index],
                                                              index: index,
                                                              servicesIndex:
                                                                  pendingBookings[
                                                                          index]
                                                                      .data![
                                                                          index]
                                                                      .packages!
                                                                      .length,
                                                              extraIndex:
                                                                  pendingBookings[
                                                                          index]
                                                                      .data![
                                                                          index]
                                                                      .extras!
                                                                      .length,
                                                            )),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    elevation: 3.0,
                                                    child: ListTile(
                                                      leading: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              '${pendingBookings[index].data![index].schedule!.startTime!.hour}:${pendingBookings[index].data![index].schedule!.startTime!.minute}-'),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              '${pendingBookings[index].data![index].schedule!.endTime!.hour}:${pendingBookings[index].data![index].schedule!.endTime!.minute}'),
                                                        ],
                                                      ),
                                                      trailing: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                debugPrint(
                                                                    'IDDDDDDDDDDDDDDDD');
                                                                debugPrint(
                                                                    'OKOKOKOKOKOKOKOKOKOK');
                                                                // print(completed[
                                                                //         0]
                                                                //     .data![
                                                                //         0]
                                                                //     .id);
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ChatsScreen(
                                                                                bookingId: pendingBookings[index].data![index].id,

                                                                                //user: null,
                                                                              )),
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .textsms_outlined,
                                                                color: Color(
                                                                    0xff206bc4),
                                                              )),
                                                        ],
                                                      ),
                                                      title: Text(
                                                          '${pendingBookings[index].data![index].bod!.bodContactInfo!.firstName}\'s Place'),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(pendingBookings[
                                                                          index]
                                                                      .data![
                                                                          index]
                                                                      .bod!
                                                                      .additionalInfo
                                                                      .toString() ==
                                                                  ''
                                                              ? 'No additional information provided'
                                                                  .tr
                                                              : pendingBookings[
                                                                      index]
                                                                  .data![index]
                                                                  .bod!
                                                                  .additionalInfo
                                                                  .toString()),
                                                          Text(
                                                              '${pendingBookings[index].data![index].bod!.bodServiceLocation!.streetAddress}, ${pendingBookings[index].data![index].bod!.bodServiceLocation!.city}'),
                                                        ],
                                                      ),
                                                      isThreeLine: true,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : Center(
                                        child: Text(
                                          'No appointments today'.tr,
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  'Completed Appointments'.tr,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                completedBookings.isNotEmpty
                                    ? MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create: (_) =>
                                                BookingListProvider(),
                                          )
                                        ],
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: completedBookings.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookingDetailsScreen(
                                                        shiftStarted: true,
                                                        booking:
                                                            completedBookings[
                                                                index],
                                                        index: index,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    elevation: 3.0,
                                                    child: ListTile(
                                                      leading: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              '${completedBookings[index].data![index].schedule!.startTime!.hour}:${completedBookings[index].data![index].schedule!.startTime!.minute}-'),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                              '${completedBookings[index].data![index].schedule!.endTime!.hour}:${completedBookings[index].data![index].schedule!.endTime!.minute}'),
                                                        ],
                                                      ),
                                                      trailing: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ChatsScreen(
                                                                                bookingId: completedBookings[index].data![index].id,
                                                                              )),
                                                                );
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .textsms_outlined,
                                                                color: Color(
                                                                    0xff206bc4),
                                                              )),
                                                        ],
                                                      ),
                                                      title: Text(
                                                          '${completedBookings[index].data![index].bod!.bodContactInfo!.firstName}\'s Place'),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(completedBookings[
                                                                          index]
                                                                      .data![
                                                                          index]
                                                                      .bod!
                                                                      .additionalInfo
                                                                      .toString() ==
                                                                  ''
                                                              ? 'No additional information provided'
                                                                  .tr
                                                              : completedBookings[
                                                                      index]
                                                                  .data![index]
                                                                  .bod!
                                                                  .additionalInfo
                                                                  .toString()),
                                                          Text(
                                                              '${completedBookings[index].data![index].bod!.bodServiceLocation!.streetAddress}, ${completedBookings[index].data![index].bod!.bodServiceLocation!.city}'),
                                                        ],
                                                      ),
                                                      isThreeLine: true,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : Center(
                                        child: Text(
                                          'No appointments today'.tr,
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const TabChat(),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: const DrawerWidget(),
    );
  }
}
