import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/constants/stat_variables.dart';
import 'package:cleany/models/booking_details_model.dart';
import 'package:cleany/variables/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../chats/chats_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  BookingDetailsScreen(
      {Key? key,
      this.booking,
      this.servicesIndex,
      this.extraIndex,
      required this.index,
      required this.shiftStarted})
      : super(key: key);
  var done = false;
  bool shiftStarted;
  BookingDetailsModel? booking;

  int index;
  var servicesIndex;
  var extraIndex;
  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  var lat;
  var long;
  var latlong;

  final List<bool> _isChecked = [false, false];
  bool isShiftEnded = false;
  bool isShiftStarted = false;

  TextEditingController workCompleteTextController = TextEditingController();

  TextEditingController workMoodTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isShiftStarted =
        widget.booking!.data![widget.index].dispatchId!.shiftStarted ?? false;
    isShiftEnded =
        widget.booking!.data![widget.index].dispatchId!.shiftEnded ?? false;
  }

  bool isAndroid = true;
  bool isIos = false;

  void stateShiftStarted() {
    setState(() {
      isShiftStarted = true;
      isShiftEnded = false;
    });
  }

  void stateShiftEnded() {
    setState(() {
      isShiftStarted = false;
      isShiftEnded = true;
    });
  }

  final _dateFormat = DateFormat('dd MMMM, yyyy');

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    // return _bookingDetails();
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backGroundColor,
        bottomNavigationBar: buttons(),
        body: SafeArea(
          child: buildBookingDetail(),
        ),
      ),
      onWillPop: () async {
        Constant.backToPrev(context);
        return false;
      },
    );
  }

  Column buildBookingDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(20)),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getDefaultHorSpace(context)),
          child: gettoolbarMenu(
            context,
            'back.svg',
            () {
              Constant.backToPrev(context);
            },
            title:
                '${'Booking ID'.tr}${widget.booking!.data![widget.index].id}',
            weight: FontWeight.w900,
            istext: true,
            textColor: Colors.black,
            fontsize: 24,
            isrightimage: true,
            rightimage: CupertinoIcons.chat_bubble_text,
            rightFunction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatsScreen(
                    bookingId: widget.booking!.data![widget.index].id,
                    // collection: widget.booking!.data![widget.index].collection,
                  ),
                ),
              );
            },
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getHorSpace(FetchPixels.getPixelWidth(24)),
            getCustomFont(
                '${'Booked on'.tr} ${_dateFormat.format(widget.booking!.data![widget.index].bod!.frequency!.startDate!)}',
                12,
                textColor,
                1,
                fontWeight: FontWeight.w400),
            getHorSpace(FetchPixels.getPixelWidth(24)),
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.booking!.data![widget.index].id.toString(),
            child: Container(
              height: FetchPixels.getPixelHeight(100),
              width: FetchPixels.getPixelHeight(100),
              decoration: BoxDecoration(
                  image:
                      getDecorationAssetImage(context, 'default_avatar.png')),
            ),
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        Expanded(
          flex: 1,
          child: ListView(
            shrinkWrap: true,
            primary: true,
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              bookingInfo(),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              details(),
            ],
          ),
        )
      ],
    );
  }

  Widget bookingInfo() {
    return Container(
      margin: EdgeInsets.only(
        bottom: FetchPixels.getPixelHeight(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
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
          // Package
          getCustomFont('Package'.tr, 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          _infoItem('user.svg', 'Name'.tr,
              '${widget.booking!.data![widget.index].bod!.bodContactInfo!.firstName} ${widget.booking!.data![widget.index].bod!.bodContactInfo!.lastName}'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _infoItem(
              'termuse.svg',
              'Type'.tr,
              widget.booking!.data![widget.index].bod!.frequency!.type ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(22)),
          //
          // Location
          getCustomFont('Location'.tr, 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          _infoItem(
              'home.svg',
              'Street Address'.tr,
              widget.booking!.data![widget.index].bod!.bodServiceLocation!
                      .streetAddress ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _infoItem(
              'location.svg',
              'City'.tr,
              GetStringUtils(widget.booking!.data![widget.index].bod!
                          .bodServiceLocation!.city)
                      ?.capitalize ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _infoItem(
              'location.svg',
              'State'.tr,
              GetStringUtils(widget.booking!.data![widget.index].bod!
                          .bodServiceLocation!.state)
                      ?.capitalize ??
                  'N/A'),
          //
          // Contact
          getVerSpace(FetchPixels.getPixelHeight(22)),
          getCustomFont('Contact'.tr, 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          _infoItem(
              'call.svg',
              'Phone Number'.tr,
              widget.booking!.data![widget.index].bod!.bodContactInfo!.phone ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _infoItem(
              'message.svg',
              'Email'.tr,
              widget.booking!.data![widget.index].bod!.bodContactInfo!.email ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _infoItem(
              'user.svg',
              'User Name'.tr,
              widget.booking!.data![widget.index].bod!.bodContactInfo!
                      .firstName ??
                  'N/A'),
        ],
      ),
    );
  }

  Widget details() {
    return Container(
      margin: EdgeInsets.only(
        bottom: FetchPixels.getPixelHeight(20),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
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
          // Package
          getCustomFont('Details'.tr, 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          // _detailsItem(
          //     'Slug'.tr,
          //     GetStringUtils(widget.booking!.data![widget.index].service?.slug)
          //             ?.capitalize ??
          //         'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _detailsItemWithOutSvg(
              'Title'.tr,
              GetStringUtils(widget.booking!.data![widget.index].service?.title)
                      ?.capitalize ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          // _detailsItem(
          //     'Status'.tr,
          //     GetStringUtils(widget.booking!.data![widget.index].service
          //             ?.status)?.capitalize ??
          //         'N/A'),
          // _detailsItem(
          //     'Cleaner Notes',
          //     widget.booking!.data![widget.index].cleanerNotes?.capitalize ??
          //         'N/A'),
          // getVerSpace(FetchPixels.getPixelHeight(8)),
          // _detailsItem(
          //     'Customer Notes',
          //     widget.booking!.data![widget.index].customerNotes?.capitalize ??
          //         'N/A'),
          // _detailsItem(
          //     'Three Days Reminder'.tr,
          //     GetStringUtils(widget.booking!.data![widget.index].threeDayReminder
          //         .toString())
          //         .capitalize!),
          _detailsItemWithOutSvg(
            'Appointment Date'.tr,
            _dateFormat.format(
                widget.booking!.data![widget.index].appointmentDateTime!),
          ),
          getVerSpace(FetchPixels.getPixelHeight(8)),

          _detailsItemWithOutSvg(
            'How to enter on premise'.tr,
            widget.booking!.data![widget.index].bod!.bodContactInfo!
                    .howToEnterOnPremise ??
                'N/A',
          ),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _detailsItemWithOutSvg(
            'Do parking spot'.tr,
            (widget.booking!.data![widget.index].bod!.bodContactInfo!
                        .parkingSpot ??
                    false)
                ? 'Yes'
                : 'No',
          ),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          _detailsItemWithOutSvg(
            'Do you have pets'.tr,
            (widget.booking!.data![widget.index].bod!.bodContactInfo!
                        .havePets!)
                // ? 'Yes'
                // : 'No',
          ),
          getVerSpace(FetchPixels.getPixelHeight(8)),
          // _detailsItem(
          //   'How did you hear about us',
          //   widget.booking!.data![widget.index].bod!.bodContactInfo!
          //           .howHearAboutUs ??
          //       'N/A',
          // ),
          getVerSpace(FetchPixels.getPixelHeight(22)),
          // Services
          getCustomFont('Services'.tr, 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          Center(
            child: getCustomFont(
                GetStringUtils(
                            widget.booking!.data![widget.index].service?.title)
                        ?.capitalize ??
                    'N/A',
                16,
                Colors.black,
                1,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.end),
          ),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          getCustomFont('Packages'.tr, 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          for (int i = 0; i < widget.servicesIndex; i++)
            Padding(
              padding: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(8)),
              child:
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     getHorSpace(FetchPixels.getPixelWidth(24)),
                  //     // getSvgImage('unselected.svg',
                  //     //     color: blueColor, width: 14, height: 14),
                  //     // getHorSpace(FetchPixels.getPixelWidth(8)),
                  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getCustomFont(
                    '${widget.booking!.data![widget.index].packages![i].item!.package_name ?? 'N/A'} Package',
                    16,
                    Colors.black,
                    2,
                    fontWeight: FontWeight.w400,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(5)),
                  Row(
                    children: [
                      getHorSpace(FetchPixels.getPixelWidth(25)),
                      getSvgImage('unselected.svg',
                          color: blueColor, width: 14, height: 14),
                      getHorSpace(FetchPixels.getPixelWidth(8)),
                      getCustomFont(
                          widget.booking!.data![widget.index].packages![i].item!
                                  .title ??
                              'N/A',
                          16,
                          Colors.black,
                          2,
                          fontWeight: FontWeight.w400),
                      getHorSpace(FetchPixels.getPixelWidth(25)),
                      getCustomFont(
                        '${widget.booking!.data![widget.index].packages![i].item!.timeHrs ?? 'N/A'} hrs',
                        16,
                        Colors.black,
                        2,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          // Extras
          // Row(
          //   children: [
          //     getCustomFont("Extra's", 18, Colors.black, 1,
          //         fontWeight: FontWeight.w900),
          //     Expanded(
          //       child: getCustomFont(
          //           widget.booking!.data![widget.index].service
          //                   ?.title ??
          //               'N/A',
          //           16,
          //           Colors.black,
          //           1,
          //           fontWeight: FontWeight.w700,
          //           textAlign: TextAlign.end),
          //     ),
          //   ],
          // ),
          getCustomFont("Extra's", 18, Colors.black, 1,
              fontWeight: FontWeight.w900),
          getVerSpace(FetchPixels.getPixelHeight(14)),
          for (int i = 0; i < widget.extraIndex; i++)
            Padding(
              padding: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHorSpace(FetchPixels.getPixelWidth(24)),
                  getSvgImage('unselected.svg',
                      color: blueColor, width: 14, height: 14),
                  getHorSpace(FetchPixels.getPixelWidth(8)),
                  getCustomFont(
                      widget.booking!.data![widget.index].extras![i].extra!
                              .title ??
                          'N/A',
                      16,
                      Colors.black,
                      2,
                      fontWeight: FontWeight.w400),
                  getHorSpace(FetchPixels.getPixelWidth(25)),
                  getCustomFont(
                      '${widget.booking!.data![widget.index].extras![i].extra!.timeHrs ?? 'N/A'} hrs',
                      16,
                      Colors.black,
                      2,
                      fontWeight: FontWeight.w400),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoItem(String svgPath, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSvgImage(svgPath, width: 18, height: 18),
        getHorSpace(FetchPixels.getPixelWidth(8)),
        getCustomFont('$title: '.tr, 16, textColor, 1,
            fontWeight: FontWeight.w400),
        Expanded(
            child: getCustomFont(value, 16, Colors.black, 2,
                fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _detailsItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getSvgImage('unselected.svg', color: blueColor, width: 14, height: 14),
        getHorSpace(FetchPixels.getPixelWidth(8)),
        getCustomFont('$title: '.tr, 16, textColor, 1,
            fontWeight: FontWeight.w400),
        Expanded(
            child: getCustomFont(value, 16, Colors.black, 2,
                fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _detailsItemWithOutSvg(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHorSpace(FetchPixels.getPixelWidth(8)),
        getCustomFont('$title: '.tr, 16, textColor, 1,
            fontWeight: FontWeight.w400),
        Expanded(
            child: getCustomFont(value, 16, Colors.black, 2,
                fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Container buttons() {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(20),
          top: FetchPixels.getPixelHeight(20)),
      child: Row(
        children: [
          Expanded(
            child: getButton(
                context, backGroundColor, 'Directions'.tr, blueColor, () async {
              // TODO: launch google maps
              if (widget.booking!.data![widget.index].dispatchId!
                          .serviceProvider!.userProfile!.longitude ==
                      null ||
                  widget.booking!.data![widget.index].dispatchId!
                          .serviceProvider!.userProfile!.latitude ==
                      null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Location Not Found'.tr),
                ));
              } else {
                await launchNativeMap();
              }
            }, 18,
                weight: FontWeight.w600,
                buttonHeight: FetchPixels.getPixelHeight(60),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(14)),
                borderColor: blueColor,
                isBorder: true,
                borderWidth: 1.5,
                isIcon: true,
                image: 'location.svg'),
          ),
          getHorSpace(FetchPixels.getPixelWidth(20)),
          !isShiftStarted
              ? Expanded(
                  child: getButton(
                    context,
                    blueColor,
                    'Start Shift',
                    Colors.white,
                    () async {
                      _shiftStart().then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Shift Started'.tr),
                                ),
                              ));
                    },
                    18,
                    weight: FontWeight.w600,
                    buttonHeight: FetchPixels.getPixelHeight(60),
                    borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(14)),
                  ),
                )
              : !isShiftEnded
                  ? Expanded(
                      child: getButton(
                        context,
                        blueColor,
                        'End Shift',
                        Colors.white,
                        () async {
                          _shiftEnd().then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Shift Ended'.tr),
                              ),
                            );
                            Navigator.pop(context);
                          });
                        },
                        18,
                        weight: FontWeight.w600,
                        buttonHeight: FetchPixels.getPixelHeight(60),
                        borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(14)),
                      ),
                    )
                  : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> _shiftStart() async {
    await showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: getCustomFont(
            'Health Check'.tr,
            18,
            Colors.black,
            1,
            fontWeight: FontWeight.w900,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont(
                'How are you feeling about cleaning today?'.tr,
                16,
                Colors.black,
                2,
                fontWeight: FontWeight.w500,
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                context,
                'Work Mood'.tr,
                workMoodTextController,
                Colors.grey,
                function: () {},
                height: FetchPixels.getPixelHeight(60),
                isEnable: false,
                withprefix: false,
                withSufix: false,
                showShadow: false,
                readOnly: false,
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: getCustomFont(
                    'I am COVID negative today'.tr,
                    16,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w500,
                  ),
                  value: isShiftStarted,
                  onChanged: (val) {
                    setState(() {
                      isShiftStarted = val!;
                      debugPrint(isShiftStarted.toString());
                    });
                  },
                ),
              ),
            ],
          ),
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
              child: getButton(
                context,
                blueColor,
                'Confirm'.tr,
                Colors.white,
                () async {
                  if (canUpload) {
                    setState(() {
                      debugPrint(widget
                          .booking!.data![widget.index].schedule!.id
                          .toString());
                      ApiRequests().startShift(
                          widget.booking!.data![widget.index].schedule!.id
                              .toString(),
                          _isChecked[0].toString(),
                          workMoodTextController.text);
                      stateShiftStarted();
                    });
                    Navigator.of(context).pop();
                  }
                },
                18,
                weight: FontWeight.w600,
                buttonHeight: FetchPixels.getPixelHeight(60),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _shiftEnd() async {
    await showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: getCustomFont(
            'Alert'.tr,
            18,
            Colors.black,
            1,
            fontWeight: FontWeight.w900,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont(
                'Tell us something about the work of today?'.tr,
                16,
                Colors.black,
                2,
                fontWeight: FontWeight.w500,
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                context,
                'Today\'s work'.tr,
                workCompleteTextController,
                Colors.grey,
                function: () {},
                height: FetchPixels.getPixelHeight(60),
                isEnable: false,
                withprefix: false,
                withSufix: false,
                showShadow: false,
                readOnly: false,
              ),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              StatefulBuilder(
                builder: (context, setState) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  title: getCustomFont(
                    'Completed all tasks'.tr,
                    16,
                    Colors.black,
                    1,
                    fontWeight: FontWeight.w500,
                  ),
                  value: isShiftEnded,
                  onChanged: (val) {
                    setState(() {
                      isShiftEnded = val!;
                    });
                  },
                ),
              ),
            ],
          ),
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(FetchPixels.getDefaultHorSpace(context)),
              child: getButton(
                context,
                blueColor,
                'Confirm'.tr,
                Colors.white,
                () async {
                  if (canUpload) {
                    Navigator.of(context).pop();

                    setState(() {
                      StatVariables.done = true;
                    });
                    setState(
                      () {
                        ApiRequests().endShift(
                          widget.booking!.data![widget.index].schedule!.id
                              .toString(),
                          isShiftEnded.toString(),
                          workCompleteTextController.text,
                        );
                      },
                    );
                  }
                },
                18,
                weight: FontWeight.w600,
                buttonHeight: FetchPixels.getPixelHeight(60),
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15)),
              ),
            ),
          ],
        );
      },
    );
  }

  launchNativeMap() async {
    debugPrint('Long');
    debugPrint(widget.booking!.data![widget.index].longitude.toString());
    debugPrint('Lat');
    debugPrint(widget.booking!.data![widget.index].dispatchId!.serviceProvider!
        .userProfile!.latitude
        .toString());

    debugPrint(widget.booking!.data![widget.index].dispatchId!.serviceProvider!
        .userProfile!.firstName);

    MapsLauncher.launchCoordinates(
        double.tryParse(
              widget.booking!.data![widget.index].dispatchId!.serviceProvider!
                      .userProfile!.latitude ??
                  '',
            ) ??
            0.0,
        double.tryParse(
              widget.booking!.data![widget.index].dispatchId!.serviceProvider!
                      .userProfile!.longitude ??
                  '',
            ) ??
            0.0,
        ' ${widget.booking!.data!.first.bod!.bodContactInfo!.firstName}\'s Place');
  }
}

// Widget _bookingDetails() {
//   return SafeArea(
//     child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(color: AppColors.appThemeColor),
//           child: Column(
//             children: [
//               Container(
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.check_circle,
//                                   size: 30.0,
//                                   color: Color.fromARGB(255, 14, 217, 28),
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Text(
//                                   'BOOKING CONFIRMED'.tr,
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.all(5),
//                   padding: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30))),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /////////////////////////////////////
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10.0),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Column(
//                                   // mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Congratulations!'.tr,
//                                           style: const TextStyle(
//                                               fontSize: 30,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'This Booking is assigned successfully to you.'.tr,
//                                           style: const TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Booking ID:'.tr,
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 15,
//                                         ),
//                                         Text(
//                                           widget
//                                               .booking!.data![widget.index].id
//                                               .toString(),
//                                           style: const TextStyle(
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Booked on:'.tr,
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 15,
//                                         ),
//                                         Text(
//                                           DateFormat.yMMMEd().format(widget
//                                               .booking!
//                                               .data![widget.index]
//                                               .bod!
//                                               .frequency!
//                                               .startDate as DateTime),
//                                           style: const TextStyle(
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text('Booking Details'.tr,
//                                       style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           fontStyle: FontStyle.italic)),
//                                   Row(
//                                     children: [
//                                       Text('Chat'.tr,
//                                           style: const TextStyle(
//                                               color: Colors.blue,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               fontStyle: FontStyle.italic)),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ChatsScreen(
//                                                     bookingId: widget
//                                                         .booking!
//                                                         .data![
//                                                     widget.index]
//                                                         .id,
//                                                   ),),);
//                                         },
//                                         child: Container(
//                                             padding: const EdgeInsets.only(
//                                                 right: 20),
//                                             child: const Icon(
//                                               Icons.chat,
//                                               color: Colors.blue,
//                                               size: 30,
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 color: Colors.white,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text('Package'.tr,
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600)),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(Icons.people_alt,
//                                             color: Colors.grey),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('Name'.tr,
//                                               style: const TextStyle(
//                                                 fontSize: 15,
//                                               ),
//                                             ),
//                                             Text(
//                                               '${widget.booking!.data![widget.index].bod!.bodContactInfo!.firstName}\'s Place',
//                                               style: const TextStyle(
//                                                   fontSize: 17,
//                                                   fontWeight:
//                                                   FontWeight.w600),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(Icons.menu,
//                                             color: Colors.grey),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('Type'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .frequency!
//                                                     .type
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//
//                               Text('Booking Location'.tr,
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 color: Colors.white,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(
//                                           Icons.location_city,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('Street Address'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .bodServiceLocation!
//                                                     .streetAddress
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(
//                                           Icons.location_history,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('State'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .bodServiceLocation!
//                                                     .state
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(Icons.add_location_alt,
//                                             color: Colors.grey),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('City'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .bodServiceLocation!
//                                                     .city
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text('Booking Contact'.tr,
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 color: Colors.white,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(
//                                           Icons.phone,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('Contact'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .bodContactInfo!
//                                                     .phone
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(
//                                           Icons.email,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('Email'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .bodContactInfo!
//                                                     .email
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         const Icon(
//                                           Icons.people_alt,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(
//                                           width: 20,
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text('User Name'.tr),
//                                             Text(
//                                                 widget
//                                                     .booking!
//                                                     .data![widget.index]
//                                                     .bod!
//                                                     .bodContactInfo!
//                                                     .firstName
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 17,
//                                                     fontWeight:
//                                                     FontWeight.w600))
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               const Text(
//                                 'Details',
//                                 style: TextStyle(
//                                   // color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 color: Colors.white,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Slug'.tr,
//                                             style: const TextStyle(
//                                               fontSize: 17,
//                                             )),
//                                         Text(
//                                             widget
//                                                 .booking
//                                                 ?.data?[widget.index]
//                                                 .bod
//                                                 ?.frequency
//                                                 ?.service
//                                                 ?.slug
//                                                 ?.toString() ??
//                                                 'N/A',
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Title'.tr,
//                                             style: const TextStyle(
//                                               fontSize: 17,
//                                             )),
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .bod!
//                                                 .frequency!
//                                                 .service
//                                                 ?.title
//                                                 .toString() ??
//                                                 "N/A",
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Status'.tr,
//                                             style: const TextStyle(
//                                               fontSize: 17,
//                                             )),
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .bod!
//                                                 .frequency!
//                                                 .service
//                                                 ?.status
//                                                 .toString() ??
//                                                 "N/A",
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Cleaner Notes'.tr,
//                                             style: const TextStyle(
//                                               fontSize: 17,
//                                             )),
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .cleanerNotes
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Customer Notes'.tr,
//                                             style: const TextStyle(
//                                               fontSize: 17,
//                                             )),
//                                         // widget.booking!.data![widget.index]
//                                         //         .customerNotes!
//                                         //         .toString()
//                                         //         .isEmpty
//                                         //     ? Text('')
//                                         //     :
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .customerNotes
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Three Days Reminder'.tr,
//                                             style: const TextStyle(
//                                               fontSize: 17,
//                                             )),
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .threeDayReminder
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                               'Appointment Date and Time'.tr,
//                                               style: const TextStyle(
//                                                 fontSize: 17,
//                                               )),
//                                         ),
//                                         Text(
//                                             DateFormat.yMMMEd().format(widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .appointmentDateTime
//                                             as DateTime),
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w600))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Services'.tr,
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.bold)),
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .bod!
//                                                 .frequency!
//                                                 .service
//                                                 ?.title
//                                                 .toString() ??
//                                                 "N/A",
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.bold))
//                                       ],
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(5),
//                                         child:  Text('Items'.tr,
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 25),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('Title'.tr,
//                                               style: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight:
//                                                   FontWeight.bold)),
//                                           for (int i = 0;
//                                           i < widget.servicesIndex;
//                                           i++)
//                                             Text(widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .packages![i]
//                                                 .item!
//                                                 .title
//                                                 .toString()),
//                                         ],
//                                       ),
//                                     ),
//
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text('Extras'.tr,
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.bold)),
//                                         Text(
//                                             widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .bod!
//                                                 .frequency!
//                                                 .service!
//                                                 .title
//                                                 .toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.bold))
//                                       ],
//                                     ),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(5),
//                                         child:  Text('Items'.tr,
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 25),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('Title'.tr,
//                                               style: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight:
//                                                   FontWeight.bold)),
//                                           for (int i = 0;
//                                           i < widget.extraIndex;
//                                           i++)
//                                             Text(widget
//                                                 .booking!
//                                                 .data![widget.index]
//                                                 .extras![i]
//                                                 .extra!
//                                                 .title
//                                                 .toString()),
//                                         ],
//                                       ),
//                                     ),
//
//                                     // ListView.builder(
//                                     //     shrinkWrap: true,
//                                     //     physics: ClampingScrollPhysics(),
//                                     //     itemBuilder: (context, index) {
//                                     //       return Container();
//                                     //     }),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.end,
//                                       children: [
//                                         // Text('Goto GoogleMap',
//                                         //     style: TextStyle(
//                                         //         fontSize: 18,
//                                         //         fontWeight:
//                                         //             FontWeight.bold)),
//                                         ElevatedButton.icon(
//                                             style: ElevatedButton.styleFrom(
//                                                 backgroundColor:
//                                                 Colors.white),
//                                             onPressed: () async {
//                                               if (widget
//                                                   .booking!
//                                                   .data![widget.index]
//                                                   .dispatchId!
//                                                   .serviceProvider!
//                                                   .userProfile!
//                                                   .longitude ==
//                                                   null) {
//                                                 ScaffoldMessenger.of(context)
//                                                     .showSnackBar(
//                                                     SnackBar(
//                                                       content: Text(
//                                                           'Location Not Found'.tr),
//                                                     ));
//                                               } else {
//                                                 await launchNativeMap();
//                                               }
//                                             },
//                                             icon: const Icon(
//                                               Icons.location_on,
//                                               color: Colors.blue,
//                                             ),
//                                             label:  Text(
//                                               'See on the Google Map'.tr,
//                                               style: const TextStyle(
//                                                   color: Colors.blue),
//                                             ))
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text('Start Shift and End Shift'.tr,
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                             ]),
//
//                         // Start SHift / End Shift
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         widget.booking!.data![widget.index].dispatchId!
//                             .shiftStarted ==
//                             false
//                             ? Align(
//                           alignment: Alignment.bottomCenter,
//                           child: ElevatedButton(
//                               onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   barrierDismissible:
//                                   true, // user must tap button!
//                                   builder: (BuildContext context) {
//                                     return AlertDialog(
//                                         title:
//                                         Text('Health Check!'.tr),
//                                         content: SizedBox(
//                                           width: MediaQuery.of(context)
//                                               .size
//                                               .width,
//                                           height: MediaQuery.of(context)
//                                               .size
//                                               .height /
//                                               4,
//                                           child: Column(
//                                             //mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               StatefulBuilder(builder:
//                                                   (BuildContext context,
//                                                   void Function(
//                                                       void
//                                                       Function())
//                                                   setState) {
//                                                 return CheckboxListTile(
//                                                   title:  Text(
//                                                       'I\'m Covid negative today'.tr),
//                                                   value: isShiftStarted,
//                                                   onChanged: (val) {
//                                                     setState(() {
//                                                       isShiftStarted =
//                                                       val!;
//                                                       debugPrint(
//                                                           isShiftStarted
//                                                               .toString());
//                                                     });
//                                                   },
//                                                 );
//                                               }),
//                                               Container(
//                                                   padding:
//                                                   const EdgeInsets
//                                                       .only(
//                                                       left: 15.0,
//                                                       right: 15.0),
//                                                   child:  Text(
//                                                       'How are you feeling about cleaning today?'.tr)),
//                                               const SizedBox(
//                                                   height: 10),
//                                               Theme(
//                                                 data: ThemeData(
//                                                   primaryColor: Colors
//                                                       .greenAccent,
//                                                   primaryColorDark:
//                                                   Colors.green,
//                                                 ),
//                                                 child: Container(
//                                                   padding:
//                                                   const EdgeInsets
//                                                       .only(
//                                                       left: 15.0,
//                                                       right: 70.0),
//                                                   child: TextField(
//                                                     controller:
//                                                     workMoodTextController,
//                                                     decoration:  InputDecoration(
//                                                         border: const OutlineInputBorder(
//                                                             borderSide: BorderSide(
//                                                                 color: Colors
//                                                                     .teal)),
//                                                         labelText:
//                                                         'Work Mood'.tr,
//                                                         suffixStyle: const TextStyle(
//                                                             color: Colors
//                                                                 .green)),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         actions: <Widget>[
//                                           Center(
//                                             child: SizedBox(
//                                                 width: MediaQuery.of(
//                                                     context)
//                                                     .size
//                                                     .width /
//                                                     2,
//                                                 child: ElevatedButton(
//                                                   onPressed: canUpload
//                                                       ? () {
//                                                     Navigator.of(
//                                                         context)
//                                                         .pop();
//                                                     ScaffoldMessenger.of(
//                                                         context)
//                                                         .showSnackBar(
//                                                         SnackBar(
//                                                           content: Text(
//                                                               'Shift Started'.tr),
//                                                         ));
//                                                     setState(() {
//                                                       debugPrint(widget
//                                                           .booking!
//                                                           .data![widget
//                                                           .index]
//                                                           .schedule!
//                                                           .id
//                                                           .toString());
//                                                       ApiRequests().startShift(
//                                                           widget
//                                                               .booking!
//                                                               .data![widget
//                                                               .index]
//                                                               .schedule!
//                                                               .id
//                                                               .toString(),
//                                                           _isChecked[0]
//                                                               .toString(),
//                                                           workMoodTextController
//                                                               .text);
//                                                       isShiftStarted =
//                                                       true;
//                                                       stateShiftStarted();
//                                                     });
//                                                   }
//                                                       : null,
//                                                   child: const Center(
//                                                       child: Text(
//                                                           'Confirm')),
//                                                 )),
//                                           )
//                                         ]);
//                                   },
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 50, vertical: 20),
//                                   textStyle: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold)),
//                               child:  Text(
//                                 'Start Shift'.tr,
//                               )),
//                         )
//                             : widget.booking!.data![widget.index].dispatchId!
//                             .shiftEnded ==
//                             false
//                             ? Align(
//                           alignment: Alignment.bottomCenter,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 barrierDismissible:
//                                 true, // user must tap button!
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title:  Text('Alert!'.tr),
//                                     content: SizedBox(
//                                       width: MediaQuery.of(context)
//                                           .size
//                                           .width,
//                                       height: MediaQuery.of(context)
//                                           .size
//                                           .height /
//                                           4,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                         children: [
//                                           StatefulBuilder(builder:
//                                               (BuildContext context,
//                                               void Function(
//                                                   void
//                                                   Function())
//                                               setState) {
//                                             return CheckboxListTile(
//                                               title:  Text(
//                                                   'Completed All the tasks'.tr),
//                                               value: isShiftEnded,
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   isShiftEnded =
//                                                   val!;
//                                                 });
//                                               },
//                                             );
//                                           }),
//                                           const SizedBox(
//                                               height: 10),
//                                           Container(
//                                               padding:
//                                               const EdgeInsets
//                                                   .only(
//                                                   left: 15.0,
//                                                   right: 15.0),
//                                               child:  Text(
//                                                   'Tell us something about the work of today!'.tr)),
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           Theme(
//                                             data: ThemeData(
//                                               primaryColor:
//                                               Colors.redAccent,
//                                               primaryColorDark:
//                                               Colors.red,
//                                             ),
//                                             child: Container(
//                                               padding:
//                                               const EdgeInsets
//                                                   .only(
//                                                   left: 15.0,
//                                                   right: 30.0),
//                                               child: TextField(
//                                                 controller:
//                                                 workCompleteTextController,
//                                                 onChanged:
//                                                     (value) {},
//                                                 decoration: const InputDecoration(
//                                                     border: OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                             color: Colors
//                                                                 .teal)),
//                                                     labelText: '',
//                                                     suffixStyle: TextStyle(
//                                                         color: Colors
//                                                             .green)),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     actions: <Widget>[
//                                       Center(
//                                         child: SizedBox(
//                                             width: MediaQuery.of(
//                                                 context)
//                                                 .size
//                                                 .width /
//                                                 2,
//                                             child: ElevatedButton(
//                                               onPressed: canUpload
//                                                   ? () {
//                                                 Navigator.of(
//                                                     context)
//                                                     .pop();
//
//                                                 setState(() {
//                                                   StatVariables
//                                                       .done =
//                                                   true;
//                                                 });
//                                                 setState(() {
//                                                   ApiRequests().endShift(
//                                                       widget
//                                                           .booking!
//                                                           .data![widget
//                                                           .index]
//                                                           .schedule!
//                                                           .id
//                                                           .toString(),
//                                                       isShiftEnded
//                                                           .toString(),
//                                                       workCompleteTextController
//                                                           .text);
//
//                                                   Navigator
//                                                       .push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             BookingDetailsScreen(
//                                                               shiftStarted: true,
//                                                               booking: widget.booking,
//                                                               index: widget.index,
//                                                             )),
//                                                   );
//                                                   ScaffoldMessenger.of(
//                                                       context)
//                                                       .showSnackBar(
//                                                       const SnackBar(
//                                                         content: Text(
//                                                             'Shift Ended'),
//                                                       ));
//                                                 });
//                                                 //Navigator.of(context).pop();
//                                               }
//                                                   : null,
//                                               child:  Center(
//                                                   child: Text(
//                                                       'Confirm'.tr)),
//                                             )),
//                                       )
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 50, vertical: 20),
//                                 textStyle: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold)),
//                             child:  Text(
//                               'End Shift'.tr,
//                             ),
//                           ),
//                         )
//                             : const Text(''),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )),
//   );
// }
