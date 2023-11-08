import 'dart:async';
import 'dart:convert';

import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/constants/stat_variables.dart';
import 'package:cleany/models/chat_room.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../auth/auth.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/data/data_file.dart';
import '../../base/models/model_chat.dart';
import '../../base/models/model_message.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

// ignore: must_be_immutable
class ChatsScreen extends StatefulWidget {
  var bookingId;

  ChatsScreen({
    Key? key,
    this.bookingId,
  }) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

// TextEditingController controllerMsg = TextEditingController();
ScrollController _scrollController = ScrollController();

class _ChatsScreenState extends State<ChatsScreen> {
  List<ModelChat> chatLists = DataFile.chatList;
  List<ModelMessage> messageLists = DataFile.messageList;

  // int index = 0;

  // ChatRoom? chatMessage;

  // List<String> contacts = [];
  ChatRoom? reversedList;
  Timer? timer;
  List chats = [];
  late IOWebSocketChannel channel;
  final TextEditingController _controller = TextEditingController();
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var token = await Authentication.token();
      channel = IOWebSocketChannel.connect(
          // 'wss://api.bookcleany.com/ws/chat/74',
          'wss://api.bookcleany.com/ws/chat/${widget.bookingId}',
          headers: {'Authorization': token});
      print(token);
      chats.clear();
      channel.stream.listen((event) {
        chats.add(jsonDecode(event));
        setState(() {});
        print('WebSocket event: $event');
      });
      channel.stream.handleError((error) {
        print('WebSocket error: $error');
      });
      channel.stream.printError();
    });

    super.initState();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final chat = {'message': _controller.text};
      final message = json.encode(chat);
      try {
        channel.sink.add(message);
        
        // channel.sink.close(status.goingAway);
        print('WebSocket message: $message');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
  // @override
  // void dispose() {
  //   timer?.cancel();
  //   // _scrollController.dispose();
  //   // chatMessage!.data!.clear();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   chatAssign();

  //   timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => recallChats());

  //   super.initState();
  // }

  // Future<void> recallChats() async {
  //   ChatRoom list = await ApiRequests().getChatsApi(widget.userId);
  //   if (list.data!.length > reversedList!.data!.length) {
  //     debugPrint('recall Chats lis is bigger than reversedlist');
  //     setState(() {
  //       reversedList = list;
  //       debugPrint(list.data!.last.message.toString());
  //       if (chatMessage!.data!.last.message !=
  //           reversedList!.data!.last.message) {
  //         chatMessage = reversedList;
  //       }
  //     });
  //   }
  // }

  // void chatAssign() async {
  //   ChatRoom list = await ApiRequests().getChatsApi(widget.userId);
  //   debugPrint(list.data!.length.toString());
  //   debugPrint('called');
  //   reversedList = list;
  //   setState(() {
  //     for (int i = 0; i < reversedList!.data!.length; i++) {
  //       debugPrint(reversedList!.data!.length.toString());
  //       chatMessage = reversedList;
  //     }
  //     // reversedList!.data!.clear();
  //   });
  // }

  _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      debugPrint('OKOKOKOKOKOKOKOKOKOK');
    } else {
      debugPrint('ASASASASASASASASASASAS');
      debugPrint('LLLLLLLLLLLLLL');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ModelChat modelChat = chatLists[index];
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(13)),
                buildHeader(context),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                buildChatList(),
                buildInputContainer(context)
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Constant.backToPrev(context);
        return false;
      },
    );
  }

  Container buildInputContainer(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(17)),
      child: Row(
        children: [
          Expanded(
            child: getDefaultTextFiledWithLabel(
              context,
              'Type a message...'.tr,
              _controller,
              textColor,
              function: () {},
              minLines: false,
              isEnable: false,
              withprefix: false,
              height: FetchPixels.getPixelHeight(60),
              alignment: Alignment.centerLeft,
            ),
          ),
          getHorSpace(FetchPixels.getPixelWidth(9)),
          GestureDetector(
            onTap: () async {
              // await ApiRequests().postMessage(
              //     controllerMsg.text.toString(), widget.collection.toString());

              // recallChats();
              _sendMessage();
              _controller.clear();
            },
            child: Container(
              padding: EdgeInsets.all(FetchPixels.getPixelHeight(9)),
              height: FetchPixels.getPixelHeight(60),
              width: FetchPixels.getPixelHeight(60),
              decoration: BoxDecoration(
                color: blueColor,
                boxShadow: [
                  BoxShadow(
                      color: blueShadow,
                      blurRadius: 10,
                      offset: const Offset(0.0, 4.0)),
                ],
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(40)),
              ),
              child: getSvgImage('send.svg'),
            ),
          )
        ],
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Constant.backToPrev(context);
          },
          child: getSvgImage('back.svg',
              width: FetchPixels.getPixelHeight(24),
              height: FetchPixels.getPixelHeight(24)),
        ),
        getHorSpace(FetchPixels.getPixelWidth(20)),
        Container(
          height: FetchPixels.getPixelHeight(50),
          width: FetchPixels.getPixelHeight(50),
          decoration: BoxDecoration(
              image: getDecorationAssetImage(context, 'default_avatar.png')),
        ),
        getHorSpace(FetchPixels.getPixelWidth(10)),
        Expanded(
          flex: 1,
          child: getCustomFont(
            'New Chat'.tr,
            20,
            Colors.black,
            1,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }

  Expanded buildChatList() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        // controller: ScrollController(),
        reverse: false,
        primary: true,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: chats.length,
        itemBuilder: (context, index) {

          // final String message = chats[index]['message'];
          final String time = '${chats[index]['created_at']}';
          final bool isMe = chats[index]['role'] == 'Cleaner';
          return Column(
            crossAxisAlignment:
                !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(16),
                        vertical: FetchPixels.getPixelHeight(13)),
                    decoration: BoxDecoration(
                        color: !isMe ? blueColor : receiverColor,
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(12))),
                    child: getMultilineCustomFont(chats[index]['message'], 16,
                        !isMe ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400, txtHeight: 1.3),
                  )
                ],
              ),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Row(
                mainAxisAlignment:
                    !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  getCustomFont(
                    time,
                    14,
                    textColor,
                    1,
                    fontWeight: FontWeight.w400,
                  ),
                  getHorSpace(FetchPixels.getPixelWidth(10)),
                  !isMe
                      ? getSvgImage('seen.svg',
                          height: FetchPixels.getPixelHeight(18),
                          width: FetchPixels.getPixelHeight(18))
                      : Container()
                ],
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
            ],
          );
        },
      ),
    );
  }

  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('WebSocket Chat'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: chats.length,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 8.0),
  //                   child: Text((chats[index] ?? '').toString()),
  //                 );
  //               },
  //             ),
  //           ),
  //           TextFormField(
  //             controller: _controller,
  //             decoration: InputDecoration(labelText: 'Send a message'),
  //           ),
  //           SizedBox(height: 8.0),
  //           ElevatedButton(
  //             child: Text('Send'),
  //             onPressed: _sendMessage,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _buildMessage(String message, bool isMe, String time) {
    final Container msg = Container(
      // alignment: Alignment.bottomCenter,
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 100.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              // right: 100.0,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        color: isMe ? Colors.blue.shade100 : const Color(0xFFFFEFEE),
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Sent: $time',
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 12.0,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        // IconButton(
        //   icon: message.isLiked
        //       ? Icon(Icons.favorite)
        //       : Icon(Icons.favorite_border),
        //   iconSize: 30.0,
        //   color: message.isLiked
        //       ? Theme.of(context).primaryColor
        //       : Colors.blueGrey,
        //   onPressed: () {},
        // )
      ],
    );
  }
}
