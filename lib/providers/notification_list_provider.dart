import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/notification_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class NotificationListProvider with ChangeNotifier {
  List<NotificationListModel> list = [];

  bool loading = false;

  //var token = Authentication.token();

  getDetails(context) async {
    loading = true;
    list = await ApiRequests().getNotificationList();
    loading = false;
    notifyListeners();
  }
}
