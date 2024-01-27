import 'dart:convert';

import 'package:cleany/models/analytics.dart';
import 'package:cleany/providers/cleaner_details_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'apis/request_apis.dart';
import 'base/resizer/fetch_pixels.dart';
import 'base/widget_utils.dart';
import 'models/cleany_tips_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<AnalyticsModel> analyticsModelFuture;
  bool isEnable = false;
  double celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  Future<AnalyticsModel> fetchData() async {
    try {
      final id = await userId();
      print(id);
      return await ApiRequests().fetchCleanerData(int.parse(id));
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      // You might want to show an error message to the user or take other actions.
      throw e;
    }
  }

  RxString name = ''.obs;
  RxString last = ''.obs;
  RxString gender = ''.obs;
  final city = ''.obs;
  final area = ''.obs;

  Future<Map<String, dynamic>> fetchWeatherData() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    const key = "0508cd206769e314e7eafb6b14500187";
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?lon=${position.longitude}&lat=${position.latitude}&appid=0508cd206769e314e7eafb6b14500187&lang=en&units=standard'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  List<TipsData> tipsList = [];

  static userId() async {
    const storage = FlutterSecureStorage();
    var userid = await storage.read(key: 'userid');
    return userid.toString();
  }

  getTips() async {
    tipsList.clear();
    setState(() {});
    final id = await userId();
    tipsList = await ApiRequests().getTipsList(int.parse(id));
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cleanerProfile = Provider.of<CleanerDetailsProvider>(context, listen: false);
      await cleanerProfile.getDetails(context);
      city.value = cleanerProfile.details[0].profile.city;
      area.value = cleanerProfile.details[0].profile.address;
      name.value = cleanerProfile.details[0].profile.firstName;
      last.value = cleanerProfile.details[0].profile.lastName;
      gender.value = cleanerProfile.details[0].profile.gender;
      getTips();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: getCustomFont(
          (() {
            if (name.value.isNotEmpty && last.value.isNotEmpty) {
              return '${name.value} ${last.value}';
            } else {
              return '';
            }
          })(),
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: FetchPixels.getPixelHeight(46),
                width: FetchPixels.getPixelHeight(46),
                decoration: BoxDecoration(
                  image: getDecorationAssetImage(context, gender.value.toLowerCase() == 'male' ? 'male.png' : 'female.png'
                      // : 'profile_image.png',
                      ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          FutureBuilder<Map<String, dynamic>>(
            future: fetchWeatherData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Lottie.asset('assets/images/Animation - 1705496270356.json'),
                );
              } else if (snapshot.hasError) {
                return const Text('');
              } else {
                final temperature = snapshot.data!['main']['temp'];
                double tempCelsius = kelvinToCelsius(temperature);
                double tempFahrenheit = celsiusToFahrenheit(tempCelsius);
                final description = snapshot.data!['weather'][0]['description'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        '${tempFahrenheit.toStringAsFixed(2)}°F',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        description.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset('assets/images/Animation - 1705496978206.json'),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Network error. Please try again.'),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          analyticsModelFuture = fetchData();
                        });
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            } else {
              final snapsh = snapshot.data as AnalyticsModel;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: size.width,
                        height: 150,
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
                                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${snapsh.totalCompletedBookings}',
                                  style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                                    style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${snapsh.totalHoursInCompletedBookings}',
                                    style: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
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
                                    'Average Hours perBooking'.tr,
                                    style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${snapsh.averageHoursPerBooking}',
                                    style: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: size.width,
                        height: 150,
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
                                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${snapsh.totalCustomersServed}',
                                  style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
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
                                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${snapsh.assignedBookings}',
                                  style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'List of Tips'.tr,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              isEnable = !isEnable;
                              setState(() {});
                            },
                            child: Text(
                              !isEnable ? 'View all'.tr : 'View less'.tr,
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    tipsList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('No tips yet.'),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      getTips();
                                    });
                                  },
                                  child: const Text('Try Again'),
                                ),
                              ],
                            ),
                          )
                        : !isEnable
                            ? Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    child: Image.asset(
                                      'assets/images/icons8-dollar.gif',
                                    ),
                                  ),
                                  title: RichText(
                                    text: TextSpan(
                                      text: 'From:'.tr,
                                      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${tipsList[0].customerName}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const TextSpan(text: "   "),
                                        TextSpan(
                                          text: '(${tipsList[0].booking})',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Tip Amount : '.tr,
                                          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 12),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '${tipsList[0].tipAmount}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    DateFormat('hh:mm a').format(
                                      DateTime.parse(
                                        tipsList[0].createdAt.toString(),
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  tileColor: Colors.white,
                                  visualDensity: VisualDensity.comfortable,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tipsList.length,
                                itemBuilder: (context, index) {
                                  print('Building item $index ${tipsList.length}');
                                  var tips = tipsList[index];
                                  print('Tips data: $tips');
                                  return Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        child: Image.asset(
                                          'assets/images/icons8-dollar.gif',
                                        ),
                                      ),
                                      title: RichText(
                                        text: TextSpan(
                                          text: 'From:'.tr,
                                          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '${tipsList[index].customerName}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const TextSpan(text: "   "),
                                            TextSpan(
                                              text: '(${tipsList[index].booking})',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Tip Amount : '.tr,
                                              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 12),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '${tipsList[index].tipAmount}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        DateFormat('hh:mm a').format(
                                          DateTime.parse(
                                            tipsList[index].createdAt.toString(),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      tileColor: Colors.white,
                                      visualDensity: VisualDensity.comfortable,
                                    ),
                                  );
                                },
                              )
                  ],
                ),
              );
            }
          }),
    );
  }
}
