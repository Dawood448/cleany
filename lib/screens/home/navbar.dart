import 'package:cleany/screens/chats/admin_chat_screen.dart';
import 'package:cleany/screens/home/tab/tab_bookings.dart';
import 'package:cleany/screens/home/tab/tab_profile.dart';
import 'package:cleany/screens/home/tab/tab_review.dart';
import 'package:flutter/material.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import 'tab/tab_chat.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  var index = 0;

  List<String> bottomBarList = ['documnet.svg', 'chat.svg', 'review.svg', 'user.svg'];

  List<Widget> tabList = [
    const TabBookings(),
    const TabChat(),
    const TabReview(),
    const TabProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double size = FetchPixels.getPixelHeight(40);
    double iconSize = FetchPixels.getPixelHeight(25);
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backGroundColor,
        body: tabList[index],
        bottomNavigationBar: buildBottomBar(size, iconSize),
        floatingActionButton: buildChatButton(), // Add the FloatingActionButton here
      ),
      onWillPop: () async {
        Constant.closeApp();
        return false;
      },
    );
  }

  Container buildBottomBar(double size, double iconSize) {
    return Container(
      height: FetchPixels.getPixelHeight(100),
      color: Colors.white,
      child: Row(
        children: List.generate(
          bottomBarList.length,
              (index1) {
            return Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    index = index1;
                  });
                },
                child: Center(
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: index == index1 ? blueColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: getSvgImage(
                        bottomBarList[index1],
                        width: iconSize,
                        height: iconSize,
                        color: index == index1 ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FloatingActionButton buildChatButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AdminChatsScreen() ));
          },
      child: Icon(Icons.chat),
      backgroundColor: Colors.blue,
    );
  }
}
