import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/booking_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class BookingListProvider with ChangeNotifier {
  List<BookingDetailsModel> list = [];
  BookingDetailsModel bookingDetailsModel = BookingDetailsModel();

  bool loading = false;

  Future getDetails(context) async {
    loading = true;
    list = await ApiRequests().getBookingetailsApi();
    loading = false;

    notifyListeners();

    // print(list.last.data!.last.createdAt);
  }
}
