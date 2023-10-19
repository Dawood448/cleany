import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/chat_list_model.dart';
import 'package:flutter/foundation.dart';

class ChattingListProvider with ChangeNotifier {
  List<ChattingListModel> list = [];

  bool loading = false;

  void getDetails(context) async {
    loading = true;

    list = await ApiRequests().getChatListApi();

    loading = false;
    notifyListeners();
  }
}
