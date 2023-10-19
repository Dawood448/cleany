import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/response_get_leaves.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LeaveListProvider with ChangeNotifier {
  List<ApiResponse> list = [];

  bool loading = false;

  getDetails(context) async {
    loading = true;
    list = await ApiRequests().getLeaveList();
    loading = false;
    notifyListeners();
  }
}
