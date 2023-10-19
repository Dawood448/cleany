import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/chat_room.dart';
import 'package:flutter/foundation.dart';

class ChatRoomProvider with ChangeNotifier {
  ChatRoom? apiResponse;

  // List <ChattingDetailsModel> list = [];

  bool loading = false;

  getDetails(context, roomId) async {
    loading = true;
    final ChatRoom list = await ApiRequests().getChatsApi(roomId);
    loading = false;

    notifyListeners();
    try {
      if (list.statusCode == 200) {
        apiResponse = list;
        // print(apiResponse.data);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      loading = false;
    }
  }
}
