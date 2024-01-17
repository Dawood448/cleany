import 'dart:developer';
import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/booking_details_model.dart';
import 'package:cleany/providers/booking_list_provider.dart';
import 'package:cleany/screens/chats/chats_screen.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../base/color_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../providers/cleaner_details_provider.dart';
import '../../../widgets/language_dailoge.dart';
import '../../booking/booking_details_screen.dart';

class TabBookings extends StatefulWidget {
  const TabBookings({Key? key}) : super(key: key);

  @override
  State<TabBookings> createState() => _TabBookingsState();
}

class _TabBookingsState extends State<TabBookings> {
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
    setState(() {
      final bookingsList =
          Provider.of<BookingListProvider>(context, listen: false);
      bookingsList
          .getDetails(context)
          .then((value) => taskAssign(bookingsList));
    });

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    super.initState();
  }

  void taskAssign(BookingListProvider bookingsList) {
    allBookings.clear();
    todayBookings.clear();
    pendingBookings.clear();
    completedBookings.clear();
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
    FetchPixels(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: getCustomFont(
            'Bookings'.tr,
            20,
            Colors.black,
            1,
            fontWeight: FontWeight.w900,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                buildLanguageDialog(context);
              },
              icon: const Icon(
                Icons.language,
                size: 25,
                color: Colors.black,
              ),
            ),
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
                  return '${cleanerProfile.details.first.profile.firstName} '
                      '${cleanerProfile.details.first.profile.lastName}';
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
                  children: [
                    ListTile(
                      leading: CircleAvatar(
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
                      title: Text(
                        '${details.bod?.bodContactInfo?.firstName ?? ''}\'s Place',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      subtitle: Text(
                        'JOB ID# ${details.id ?? ''}'.tr,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(7),
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
                            color: details.schedule?.shiftStatus == 'pending'.tr
                                ? error
                                : details.schedule?.shiftStatus ==
                                        'completed'.tr
                                    ? completed
                                    : success,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Service: '.tr,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          details.service!.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    Row(
                      children: [
                        Text(
                          'Start: '.tr,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          _dateFormat.format(
                              details.schedule?.startTime ?? DateTime.now()),
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
                        Text(
                          'From: '.tr,
                          style: const TextStyle(
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
                        Text(
                          'Total Hours: '.tr,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          ' ${details.totalHours.toString()}H',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              fontSize: 12),
                        ),
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
}
