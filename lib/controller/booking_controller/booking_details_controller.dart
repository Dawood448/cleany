import 'dart:convert';

import 'package:cleany/models/booking_details_model.dart';
import 'package:get/get.dart';

import '../../apis/request_apis.dart';

class BookingDetailsController extends GetxController{
  bool loading = false;
  BookingDetailsData bookingDetailsData = BookingDetailsData();
  Future<BookingDetailsModel?> getBookingDetail(id) async {
    loading = true;
    bookingDetailsData = await ApiRequests().getBookingDetailApi(id);
    loading = false;
    update();
  }
}