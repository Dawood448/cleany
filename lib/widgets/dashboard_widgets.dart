import 'package:cleany/screens/booking/booking_details_screen.dart';
import 'package:cleany/screens/chats/chats_screen.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget notifications = ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 10,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           BookingDetailsScreen()),
          // );
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: Material(
            borderRadius: BorderRadius.circular(7),
            elevation: 3.0,
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_active_outlined),
                ],
              ),
              title: const Text(
                'New Task',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('New Booking available'),
              //isThreeLine: true,
            ),
          ),
        ),
      );
    });

Widget todayTask = ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 4,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingDetailsScreen(
                      shiftStarted: true,
                      index: index,
                    )),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: Material(
            borderRadius: BorderRadius.circular(7),
            elevation: 3.0,
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('2.00 PM -\n5.00 PM'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatsScreen(
                                  //user: null,
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.textsms_outlined,
                        color: Color(0xff206bc4),
                      )),
                ],
              ),
              title: const Text("Lucy's Place"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Gotta clean the kitchen'),
                  Text('Shantinagar'),
                ],
              ),
              isThreeLine: true,
            ),
          ),
        ),
      );
    });

Widget pendingTask = MultiProvider(
  providers: const [],
  child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingDetailsScreen(
                        shiftStarted: true,
                        index: index,
                      )),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(top: 15.0),
            child: Material(
              borderRadius: BorderRadius.circular(7),
              elevation: 3.0,
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('2.00 PM -\n5.00 PM'),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatsScreen(
                                    //user: null,
                                    )),
                          );
                        },
                        icon: const Icon(
                          Icons.textsms_outlined,
                          color: Color(0xff206bc4),
                        )),
                  ],
                ),
                title: const Text("Lucy's Place"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Gotta clean the kitchen'),
                    Text('Shantinagar'),
                  ],
                ),
                isThreeLine: true,
              ),
            ),
          ),
        );
      }),
);

Widget completedTask = ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 7,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.customerDetails);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: Material(
            borderRadius: BorderRadius.circular(7),
            elevation: 3.0,
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('2.00 PM -\n5.00 PM'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatsScreen(
                                  //user: null,
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.textsms_outlined,
                        color: Color(0xff206bc4),
                      )),
                ],
              ),
              title: const Text("Lucy's Place"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Gotta clean the kitchen'),
                  Text('Shantinagar'),
                ],
              ),
              isThreeLine: true,
            ),
          ),
        ),
      );
    });
