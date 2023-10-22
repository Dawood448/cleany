import 'package:cleany/models/chat_list_model.dart';
import 'package:cleany/models/message_model.dart';
import 'package:cleany/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentChats extends StatefulWidget {
  List<ChattingListModel> chats = [];

  RecentChats({Key? key, required this.chats}) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: widget.chats.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatsScreen(
                        // userId: widget.chats[index].data![index].id,
                        // chatName: const [
                        //   // widget.chats[index].data![index].chat![index].user!
                        //   // .userProfile!.firstName,
                        // ]
                        ),
                  ),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: chat.unread ? Colors.blue.shade100 : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.green.shade200,
                            //backgroundImage: AssetImage(chat.sender.imageUrl),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text(
                              //   widget.chats[index].data![index].chat![index]
                              //           .user!.userProfile!.firstName
                              //           .toString() +
                              //       ', ' +
                              //       widget
                              //           .chats[index]
                              //           .data![index + 1]
                              //           .chat![index + 1]
                              //           .user!
                              //           .userProfile!
                              //           .firstName
                              //           .toString(),
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 15.0,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: const Text(
                                  '',
                                  // widget.chats[index].data![index].chat![index]
                                  //     .user!.userProfile!.firstName
                                  //     .toString(),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            chat.time,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          chat.unread
                              ? Container(
                                  width: 40.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment: Alignment.center,
                                  child:  Text(
                                    'NEW'.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
