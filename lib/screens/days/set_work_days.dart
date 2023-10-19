import 'dart:async';

import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/constants/app_colors.dart';
import 'package:cleany/providers/leave_list_provider.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class SetWorkDays extends StatefulWidget {
  const SetWorkDays({Key? key}) : super(key: key);

  @override
  State<SetWorkDays> createState() => _SetWorkDaysState();
}

class _SetWorkDaysState extends State<SetWorkDays> {
  String? _hour, _minute, _time;

  String? _hour1, _minute1, _time1;

  TimeOfDay _selectedTime = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay _selectedTime1 = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController1 = TextEditingController();
  final TextEditingController _timeController1 = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        _dateController1.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController1.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        // _dateController1.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null)
      setState(() {
        _selectedTime = picked;
        _hour = _selectedTime.hour.toString();
        _minute = _selectedTime.minute.toString();

        _time = '${_hour!}:${_minute!}';
        _timeController.text = _time!;
        // _timeController1.text = _time!;
        final f = DateFormat('hh:mm');
        // _timeController1.text =
        //     f.format(DateTime.fromMillisecondsSinceEpoch(selectedTime.hour));
        f.format(DateTime(_selectedTime.hour));
        // print(_timeController.text);
        // formatDate(DateTime(selectedTime.hour), [])
        //     .toString();
      });
  }

  Future<void> _selectTime1(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime1,
    );
    if (picked != null)
      setState(() {
        _selectedTime1 = picked;
        _hour1 = _selectedTime1.hour.toString();
        _minute1 = _selectedTime1.minute.toString();
        _time1 = '${_hour1!}:${_minute1!}';
        // _timeController.text = _time!;
        _timeController1.text = _time1!;
        // final f = new DateFormat('hh:mm');
        // _timeController1.text =
        //     f.format(DateTime.fromMillisecondsSinceEpoch(selectedTime1.hour));
        // _timeController.text =
        //     f.format(DateTime.fromMillisecondsSinceEpoch(selectedTime.hour));
        // formatDate(
        //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        //     [hh, ':', nn, ""]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _dateController1.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    _timeController.text = formatDate(DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute), [
      hh,
      ':',
      nn,
    ]).toString();

    _timeController1.text = formatDate(DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute), [
      hh,
      ':',
      nn,
    ]).toString();

    // late ApiResponse apiResponse;
    // print(apiResponse.data);
    super.initState();
  }

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDate = DateTime.now();
  DateTime focusDate = DateTime.now();

  final _dateFormat = DateFormat.jm().addPattern('dd MMMM, yyyy');

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
      onWillPop: () async {
        Constant.backToPrev(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backGroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: buildHeader(context),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: titleField(),
              ),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              buildContent(),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
                child: getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              buildWorkDaysList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWorkDaysList() {
    final getLeave = Provider.of<LeaveListProvider>(context);
    return Expanded(
      flex: 1,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
        itemCount: getLeave.list.length,
        // itemCount: 10,
        itemBuilder: (_, index) {
          return Dismissible(
            key: ObjectKey(getLeave.list.elementAt(index)),
            onDismissed: (direction) async {
              var response = await ApiRequests().deleteLeave(getLeave.list[index].data![index].id);

              if (response == 200) {
                setState(() {
                  getLeave.list.removeAt(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Leave removed!'),
                    ),
                  );
                });
              } else {
                if (context.mounted)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something went wrong with leave deletion!'),
                    ),
                  );
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: FetchPixels.getPixelHeight(20),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
                ],
                borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(16),
                vertical: FetchPixels.getPixelHeight(16),
              ),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (() {
                      if (getLeave.list[index].data![index].title != null) {
                        return getLeave.list[index].data![index].title!.isNotEmpty
                            ? getLeave.list[index].data![index].title!
                            : 'N/A';
                      } else {
                        return 'N/A';
                      }
                    })(),
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(15)),
                  Text(
                    'Start Date: ${_dateFormat.format(DateTime.tryParse(getLeave.list[index].data![index].start ?? '') ?? DateTime.now())}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(8)),
                  Text(
                    'End Date: ${_dateFormat.format(DateTime.tryParse(getLeave.list[index].data![index].end ?? '') ?? DateTime.now())}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(8)),
                  Text(
                    'Service Provider: ${getLeave.list[index].data![index].serviceProvider}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ],
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: FetchPixels.getPixelWidth(16),
        vertical: FetchPixels.getPixelHeight(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Schedule',
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Row(
            children: [
              Expanded(
                child: getDefaultTextFiledWithLabel(
                  context,
                  'Start Date',
                  _dateController,
                  Colors.grey,
                  function: () => _selectDate(context),
                  height: FetchPixels.getPixelHeight(60),
                  isEnable: false,
                  withprefix: false,
                  withSufix: true,
                  showShadow: false,
                  readOnly: true,
                  suffiximage: 'calender.svg',
                  imagefunction: () => _selectDate(context),
                ),
              ),
              getHorSpace(FetchPixels.getPixelWidth(20)),
              Expanded(
                child: getDefaultTextFiledWithLabel(
                  context,
                  'Start Time',
                  _timeController,
                  Colors.grey,
                  function: () => _selectTime(context),
                  height: FetchPixels.getPixelHeight(60),
                  isEnable: false,
                  withprefix: false,
                  withSufix: true,
                  showShadow: false,
                  readOnly: true,
                  suffiximage: 'clock.svg',
                  imagefunction: () => _selectTime(context),
                ),
              ),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          Row(
            children: [
              Expanded(
                child: getDefaultTextFiledWithLabel(
                  context,
                  'End Date',
                  _dateController1,
                  Colors.grey,
                  function: () => _selectDate1(context),
                  height: FetchPixels.getPixelHeight(60),
                  isEnable: false,
                  withprefix: false,
                  withSufix: true,
                  showShadow: false,
                  readOnly: true,
                  suffiximage: 'calender.svg',
                  imagefunction: () => _selectDate1(context),
                ),
              ),
              getHorSpace(FetchPixels.getPixelWidth(20)),
              Expanded(
                child: getDefaultTextFiledWithLabel(
                  context,
                  'End Time',
                  _timeController1,
                  Colors.grey,
                  function: () => _selectTime1(context),
                  height: FetchPixels.getPixelHeight(60),
                  isEnable: false,
                  withprefix: false,
                  withSufix: true,
                  showShadow: false,
                  readOnly: true,
                  suffiximage: 'clock.svg',
                  imagefunction: () => _selectTime1(context),
                ),
              ),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          getButton(
            context,
            blueColor,
            'Submit',
            Colors.white,
            () async {
              var startDatetime = '${_dateController.text}T${_timeController.text}';
              var endDateTime = '${_dateController1.text}T${_timeController1.text}';

              int responseVal;

              responseVal = await ApiRequests()
                  .postLeave(startDatetime.toString(), endDateTime.toString(), _titleController.text);
              if (responseVal == 200) {
                if (mounted) Navigator.pushNamed(context, AppRoutes.loading);
              } else {
                if (mounted)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Something went wrong while creating leave'),
                    ),
                  );
              }
            },
            18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
          )
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return gettoolbarMenu(
      context,
      'back.svg',
      () {
        Constant.backToPrev(context);
      },
      istext: true,
      title: 'Set Work Days',
      weight: FontWeight.w900,
      fontsize: 24,
      textColor: Colors.black,
    );
  }

  Widget titleField() {
    return getDefaultTextFiledWithLabel(
      context,
      'Title',
      _titleController,
      Colors.grey,
      function: () {},
      height: FetchPixels.getPixelHeight(60),
      isEnable: false,
      withprefix: true,
      image: 'documnet.svg',
      imageWidth: FetchPixels.getPixelWidth(19),
      imageHeight: FetchPixels.getPixelHeight(17.66),
    );
  }

  Widget _body() {
    final getLeave = Provider.of<LeaveListProvider>(context);
    return Container(
      color: AppColors.appThemeColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 5, //<-- SEE HERE
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Enter Title'),
                        ),
                        Row(
                          children: const [
                            Text(
                              'Choose Start Date/Time',
                              style: TextStyle(
                                  // fontStyle: FontStyle.,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.1),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    width: 220,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (String? val) {},
                                      decoration: InputDecoration(
                                          disabledBorder:
                                              const UnderlineInputBorder(borderSide: BorderSide.none),
                                          // labelText: 'Time',
                                          contentPadding: const EdgeInsets.only(top: 0.0),
                                          suffix: ElevatedButton(
                                            onPressed: () {
                                              _selectDate(context);
                                            },
                                            child: const Icon(
                                              Icons.calendar_view_month_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectTime(context);
                                  },
                                  child: Container(
                                    width: 220,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      onSaved: (String? val) {},
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _timeController,
                                      decoration: InputDecoration(
                                        disabledBorder:
                                            const UnderlineInputBorder(borderSide: BorderSide.none),
                                        // labelText: 'Time',
                                        contentPadding: const EdgeInsets.all(0),
                                        suffix: ElevatedButton(
                                          onPressed: () {
                                            _selectTime(context);
                                          },
                                          child: const Icon(
                                            Icons.timer,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Choose End Date/Time',
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.1),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectDate1(context);
                                  },
                                  child: Container(
                                    width: 220,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController1,
                                      onSaved: (String? val) {},
                                      decoration: InputDecoration(
                                          disabledBorder:
                                              const UnderlineInputBorder(borderSide: BorderSide.none),
                                          contentPadding: const EdgeInsets.only(top: 0.0),
                                          suffix: ElevatedButton(
                                            onPressed: () {
                                              _selectDate1(context);
                                            },
                                            child: const Icon(
                                              Icons.calendar_view_month_outlined,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _selectTime1(context);
                                  },
                                  child: Container(
                                    width: 220,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.grey[200]),
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      onSaved: (String? val) {},
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _timeController1,
                                      decoration: InputDecoration(
                                        disabledBorder:
                                            const UnderlineInputBorder(borderSide: BorderSide.none),
                                        contentPadding: const EdgeInsets.all(0),
                                        suffix: ElevatedButton(
                                          onPressed: () {
                                            _selectTime1(context);
                                          },
                                          child: const Icon(
                                            Icons.timer,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var startDatetime = '${_dateController.text}T${_timeController.text}';

                            var endDateTime = '${_dateController1.text}T${_timeController1.text}';

                            var responseVal;

                            responseVal = await ApiRequests().postLeave(
                                startDatetime.toString(), endDateTime.toString(), _titleController.text);
                            if (responseVal == 200) {
                              if (mounted) Navigator.pushNamed(context, AppRoutes.loading);
                            } else {
                              if (mounted)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Leave Created Unsuccessfully')));
                            }
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                        ),
                        child: InkWell(
                          onTap: () async {},
                          child: MultiProvider(
                            providers: [ChangeNotifierProvider(create: (_) => LeaveListProvider())],
                            child: ListView.builder(
                              itemCount: getLeave.list.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {},
                                  child: Dismissible(
                                    key: ObjectKey(getLeave.list.elementAt(index)),
                                    onDismissed: (direction) async {
                                      var response = await ApiRequests()
                                          .deleteLeave(getLeave.list[index].data![index].id);

                                      if (response == 200) {
                                      } else {
                                        debugPrint('NOTOKOKOKOKOKOKOK');
                                      }
                                      setState(() {
                                        getLeave.list.removeAt(index);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Deleted SuccussFully!!!')));
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  getLeave.list[index].data![index].title.toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Start Date:',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      getLeave.list[index].data![index].start.toString(),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'End Date:',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      getLeave.list[index].data![index].end.toString(),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Service Provider:',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      getLeave.list[index].data![index].serviceProvider
                                                          .toString(),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
