import 'dart:core';

import 'package:cleany/base/widget_utils.dart';
import 'package:cleany/models/booking_details_model.dart';
import 'package:cleany/providers/booking_list_provider.dart';
import 'package:cleany/screens/booking/booking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<BookingDetailsModel> getBooking = [];

  final _timeFormat = DateFormat.jm();
  final _dateFormat = DateFormat('dd MMMM, yyyy');

  List<BookingDetailsModel> calendarEvents() {
    for (int i = 0; i < getBooking.length; i++) {
      if (focusDate == null) {
        return getBooking;
      } else {
        return getBooking
            .where((element) =>
                element.data![i].schedule!.startTime!.year == focusDate.year &&
                element.data![i].schedule!.startTime!.month == focusDate.month &&
                element.data![i].schedule!.startTime!.day == focusDate.day)
            .toList();
      }
    }
    return getBooking;
  }

  @override
  void initState() {
    final postModel = Provider.of<BookingListProvider>(context, listen: false);

    for (int i = 0; i < postModel.list.length; i++) {
      debugPrint(postModel.list[i].data![i].createdAt.toString());
      getBooking.add(postModel.list[i]);
      debugPrint('Booking');
      debugPrint(getBooking[i].data![i].createdAt.toString());
    }

    super.initState();
  }

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDate = DateTime.now();
  DateTime focusDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
      onWillPop: () async {
        Constant.backToPrev(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backGroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: buildHeader(context),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              buildCalender(),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              buildBookingList(),
              // _empty(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingList() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
        itemCount: calendarEvents().length,
        // itemCount: 10,
        itemBuilder: (_, index) {
          BookingDetailsModel bookingDetailsModel = calendarEvents()[index];
          return GestureDetector(
            child: buildBookingItem(bookingDetailsModel.data?[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetailsScreen(
                    shiftStarted: true,
                    booking: bookingDetailsModel,
                    index: index,
                    servicesIndex: bookingDetailsModel.data![index].packages!.length,
                    extraIndex: bookingDetailsModel.data![index].extras!.length,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildBookingItem(BookingDetailsData? details) {
    return Container(
      margin: EdgeInsets.only(
        bottom: FetchPixels.getPixelHeight(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
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
              'Something went wrong'.tr,
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
                      child: getAssetImage(
                        'default_avatar.png',
                        FetchPixels.getPixelHeight(58),
                        FetchPixels.getPixelHeight(58),
                      ),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${details.bod?.bodContactInfo?.firstName ?? ''}\'s Place',
                          style:
                              const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(8)),
                        Text(
                          _dateFormat.format(details.schedule?.startTime ?? DateTime.now()),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(5)),
                        Text(
                          'From ${_timeFormat.format(details.schedule?.startTime ?? DateTime.now())} to ${_timeFormat.format(details.schedule?.endTime ?? DateTime.now())}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    if (details.schedule?.shiftStatus?.isNotEmpty ?? false) ...[
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
                          GetStringUtils(details.schedule?.shiftStatus)?.capitalize ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: details.schedule?.shiftStatus == 'pending'
                                ? error
                                : details.schedule?.shiftStatus == 'completed'
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
                    getSvgImage('call.svg'),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    Text(
                      details.bod?.bodContactInfo?.phone ?? 'N/A',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(30)),
                    getSvgImage('location.svg'),
                    getHorSpace(FetchPixels.getPixelWidth(10)),
                    Expanded(
                      child: Text(
                        details.bod?.bodServiceLocation?.streetAddress ?? 'N/A',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _empty() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: calendarEvents().length,
          itemBuilder: (BuildContext context, int index) {
            BookingDetailsModel bookingDetailsModel = calendarEvents()[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingDetailsScreen(
                      shiftStarted: true,
                      booking: bookingDetailsModel,
                      index: index,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bookingDetailsModel.data![index].bod!.startTime.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const Text(
                                '-',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                bookingDetailsModel.data![index].bod!.startTime.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA3E9F7),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      bookingDetailsModel.data![index].bod!.bodContactInfo!.firstName
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Place',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    image: const DecorationImage(
                                      image: AssetImage('assets/images/blankimage.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Icon(Icons.phone),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Contact No:'.tr,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(bookingDetailsModel.data![index].bod!.bodContactInfo!.phone.toString())
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    Icon(Icons.calendar_today_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Date:'.tr,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(DateFormat.yMMMEd()
                                    .format(bookingDetailsModel.data![index].schedule!.startTime as DateTime)
                                    .toString())
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children:  [
                                      Icon(Icons.location_city),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Address:'.tr,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    bookingDetailsModel.data![index].bod!.bodServiceLocation!.streetAddress
                                        .toString(),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCalender() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getPixelWidth(16),
          vertical: FetchPixels.getPixelHeight(16),
        ),
        child: TableCalendar(
          shouldFillViewport: false,
          rowHeight: FetchPixels.getPixelHeight(44),
          focusedDay: focusDate,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onDaySelected: (DateTime selectedDay, DateTime focusDay) async {
            setState(() {
              selectedDate = selectedDay;
              focusDate = focusDay;
            });
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            selectedDecoration: BoxDecoration(
              color: blueColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: blueColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(0.0, 4.0)),
              ],
            ),
            todayTextStyle: const TextStyle(color: Colors.white),
            withinRangeTextStyle: const TextStyle(color: Colors.red),
            weekendTextStyle: const TextStyle(color: Colors.grey),
            outsideTextStyle: const TextStyle(color: Colors.white60),
            todayDecoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
            selectedTextStyle: const TextStyle(color: Colors.white),
          ),
          headerStyle: const HeaderStyle(
            leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
            rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
            titleCentered: true,
            formatButtonVisible: false,
          ),
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDate, date);
          },
          onFormatChanged: (CalendarFormat format) {
            setState(() {
              format = format;
            });
          },
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return gettoolbarMenu(
      context,
      'back.svg',
      () {
        Constant.backToPrev(context);
      },
      istext: true,
      title: 'Schedule'.tr,
      weight: FontWeight.w900,
      fontsize: 24,
      textColor: Colors.black,
    );
  }
}
