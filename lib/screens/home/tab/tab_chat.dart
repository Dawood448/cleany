import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/providers/chatting_list_provider.dart';
import 'package:cleany/screens/notification/notification_screen.dart';
import 'package:cleany/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../base/color_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';

class TabChat extends StatefulWidget {
  const TabChat({Key? key}) : super(key: key);

  @override
  State<TabChat> createState() => _TabChatState();
}

class _TabChatState extends State<TabChat> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Align(
            alignment: Alignment.topCenter,
            child: getCustomFont('Chats'.tr, 24, Colors.black, 1, fontWeight: FontWeight.w900),
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          buildExpanded()
        ],
      ),
    );
  }

  Expanded buildExpanded() {
    final getChat = Provider.of<ChattingListProvider>(context);
    return Expanded(
      flex: 1,
      child: (getChat.list.isEmpty) ? nullListView() : chatList(),
    );
  }

  Widget chatList() {
    final getChat = Provider.of<ChattingListProvider>(context);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: getChat.list.length,
      padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // TODO: Move to chat screen
          },
          child: Container(
            margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(12), vertical: FetchPixels.getPixelHeight(12)),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
                ],
                borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
            child: Row(
              children: [
                Container(
                  height: FetchPixels.getPixelHeight(56),
                  width: FetchPixels.getPixelHeight(56),
                  decoration: BoxDecoration(image: getDecorationAssetImage(context, 'default_avatar.png')),
                ),
                getHorSpace(FetchPixels.getPixelWidth(12)),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: getCustomFont(
                                '${getChat.list[index].data![index].userFirstName.toString()} ${getChat.list[index].data![index].userLastName}',
                                16,
                                Colors.black,
                                1,
                                fontWeight: FontWeight.w900),
                          ),
                          getCustomFont(
                            timeago.format(
                                DateTime.tryParse(getChat.list[index].data![index].updatedAt ?? '') ??
                                    DateTime.now(),
                                locale: 'en_short'),
                            14,
                            textColor,
                            1,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getCustomFont(getChat.list[index].data![index].message ?? '', 14, textColor, 1,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget nullListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage('chat_screen.svg',
            height: FetchPixels.getPixelHeight(124), width: FetchPixels.getPixelHeight(124)),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getCustomFont('No Chats Yet!', 20, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center)
      ],
    );
  }

  Widget _chats() {
    final getChat = Provider.of<ChattingListProvider>(context);
    debugPrint('LLLLLLLLLLLLLLLLLLL');

    debugPrint('LENGHTHTHTHTHTHTH   ${getChat.list.length} ');
    return SafeArea(
      child: Scaffold(
        key: _scaffold,
        drawer: DrawerWidget(),
        backgroundColor: AppColors.appThemeColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: AppColors.appThemeColor),
          child: Column(
            children: <Widget>[
              //CategorySelector(),
              Column(
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: AppColors.appThemeColor,
                    ),
                    child: ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _scaffold.currentState!.openDrawer();
                                    },
                                    child: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Text(
                                    'CHATS',
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => const NotificationScreen()));
                                },
                                child: Image.asset(
                                  'assets/images/notification.png',
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: MultiProvider(
                    providers: [ChangeNotifierProvider(create: (_) => ChattingListProvider())],
                    child: ListView.builder(
                      itemCount: getChat.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        //  DateTime time =
                        //   var time = DateTime( _getChat.list[index]
                        // .data![index].createdAt!;
                        //      +
                        // ':' +
                        // chatMessage!.data![index].createdAt!.minute
                        //     .toString();
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Container(
                                  // padding: EdgeInsets.symmetric(),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          getChat.list[index].data![index].message.toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          '${getChat.list[index].data![index].userFirstName.toString()} ${getChat.list[index].data![index].userLastName}',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
