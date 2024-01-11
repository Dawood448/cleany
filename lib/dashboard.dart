import 'package:cleany/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'apis/request_apis.dart';
import 'base/widget_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashBoardList = [];
  void fetchData() async {
    try {
      Map<String, dynamic> cleanerData = await ApiRequests().fetchCleanerData(4);
      // Handle the data as needed
      print(cleanerData);
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  @override
  void initState() {
   // final data = ApiRequests().fetchCleanerData(4);
   // dashBoardList.add(data);
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(dashBoardList);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Dashboard'.tr,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Completed Bookings'.tr,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Dashboard'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/icons8-web-analytics-64.png'),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icons8-booking-64.png',
                            // height: 50,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Total Hours'.tr,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Dashboard'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/icons8-booking-80.png',
                            height: 65,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Average Hours per Booking'.tr,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Dashboard'.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                width: size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Customer Served'.tr,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Dashboard'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/icons8-chart-50.png',
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              child: Container(
                width: size.width,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Assigned Bookings'.tr,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Dashboard'.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/icons8-calendar.gif',
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
