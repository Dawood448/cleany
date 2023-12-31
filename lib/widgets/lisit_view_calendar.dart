import 'dart:core';

import 'package:cleany/models/booking_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListViewCalendar extends StatefulWidget {
  int index;
  List<BookingDetailsModel> getBooking = [];

  ListViewCalendar(this.index, this.getBooking, {Key? key}) : super(key: key);

  @override
  State<ListViewCalendar> createState() => _ListViewCalendarState();
}

class _ListViewCalendarState extends State<ListViewCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.getBooking[widget.index].data![widget.index].bod!.bodContactInfo!.firstName
                      .toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                 Text(
                  'Place'.tr,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Contact No:'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    widget.getBooking[widget.index].data![widget.index].bod!.bodContactInfo!.phone.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Address:'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget
                    .getBooking[widget.index].data![widget.index].bod!.bodServiceLocation!.streetAddress
                    .toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Date:'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMEd().format(
                      widget.getBooking[widget.index].data![widget.index].schedule!.createdAt as DateTime),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
