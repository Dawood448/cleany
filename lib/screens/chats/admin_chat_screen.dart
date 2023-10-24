import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cleany/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../auth/auth.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/data/data_file.dart';
import '../../base/models/model_message.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class AdminChatsScreen extends StatefulWidget {
  const AdminChatsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminChatsScreen> createState() => _AdminChatsScreenState();
}

ScrollController _scrollController = ScrollController();

class _AdminChatsScreenState extends State<AdminChatsScreen> {

  List<ModelMessage> messageLists = DataFile.messageList;

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
          'wss://api.bookcleany.com/ws/user_chat?',
          headers: {'Authorization': token});
      chats.clear();
      channel.stream.listen((event) {
        chats.add(jsonDecode(event));
        setState(() {});
      });
      channel.stream.handleError((error) {
        log('WebSocket error: $error');
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
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        getHorSpace(FetchPixels.getPixelWidth(120)),
        Expanded(
          flex: 1,
          child: getCustomFont(
            'Chat with Admin'.tr,
            18,
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
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: FetchPixels.getPixelWidth(16),
                        vertical: FetchPixels.getPixelHeight(13)),
                    decoration: BoxDecoration(
                        color: isMe ? blueColor : receiverColor,
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(12))),
                    child: getMultilineCustomFont(chats[index]['message'], 16,
                        isMe ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w400, txtHeight: 1.3),
                  )
                ],
              ),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  getCustomFont(
                    time,
                    14,
                    textColor,
                    1,
                    fontWeight: FontWeight.w400,
                  ),
                  getHorSpace(FetchPixels.getPixelWidth(10)),
                  isMe
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
}
