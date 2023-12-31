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

          getVerSpace(FetchPixels.getPixelHeight(8)),
          _detailsItemWithOutSvg(
              'Title'.tr,
              GetStringUtils(widget.booking!.data![widget.index].service?.title)
                      ?.capitalize ??
                  'N/A'),
          getVerSpace(FetchPixels.getPixelHeight(8)),
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
                        .havePets ??
                    false)
                ? 'Yes'
                : 'No',
          ),
          getVerSpace(FetchPixels.getPixelHeight(8)),

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

