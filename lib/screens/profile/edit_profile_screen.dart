import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/providers/cleaner_details_provider.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timezone_dropdown/timezone_dropdown.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController firstEditingController = TextEditingController();
  TextEditingController lastEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController contactEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController zipEditingController = TextEditingController();
  TextEditingController stateEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  bool isLocationEnabled = true;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // String? dropDownValue;

  // List of items in our dropdown menu
  var items = [
    'Active',
    'Inactive',
  ];
  bool showShadow = true;

  // ignore: unused_field
  static String? dropdownValue;

  navigate() {
    CleanerDetailsProvider cleanerProfile = Provider.of<CleanerDetailsProvider>(context, listen: false);
    cleanerProfile.getDetails(context);
    // LoadingScreen().createState().callProviders(),
    Navigator.pushNamed(context, AppRoutes.profile);
    debugPrint('YES');
  }

  updateProfile() async {
    //final profileUpdate  = Provider.of<CleanerDetailsUpdateProvider>(context);
    // if (formKey.currentState!.validate()) {
    //final scaffold = Scaffold.of(context);
    final email = emailEditingController.text;
    final firstName = firstEditingController.text;
    final lastName = lastEditingController.text;
    final address = addressEditingController.text;
    final city = cityEditingController.text;
    final zipcode = zipEditingController.text;
    final phone = contactEditingController.text;
    final state = stateEditingController.text;
    final ssn = phoneEditingController.text;
    // final status = dropDownValue.toString();
    print("---------------------object ${email}, ${firstName}, ${lastName}, ${phone}, ${address}, ${city}, ${zipcode}, ${ssn}, ${state}");

    var responseVal = await ApiRequests().patchProfileDetailsApi(email, firstName, lastName, phone, address, city, zipcode, ssn, state, ssn);
    debugPrint(responseVal.toString());
    responseVal == '200' ? navigate() : debugPrint('NO');
    //ApiRequests().getProfileDetails();
    // }
  }

  @override
  void initState() {
    //setInitalData();
    super.initState();
  }

  setInitalData(CleanerDetailsProvider cleanerProfile) {
    for (int i = 0; i < cleanerProfile.details.length; i++) {
      emailEditingController.text = cleanerProfile.details[i].email.toString();
      firstEditingController.text = cleanerProfile.details[i].profile.firstName.toString();
      lastEditingController.text = cleanerProfile.details[i].profile.lastName.toString();
      contactEditingController.text = cleanerProfile.details[i].profile.country.toString();
      addressEditingController.text = cleanerProfile.details[i].profile.address.toString();
      cityEditingController.text = cleanerProfile.details[i].profile.city.toString();
      zipEditingController.text = cleanerProfile.details[i].profile.zipCode.toString();
      stateEditingController.text = cleanerProfile.details[i].profile.state.toString();
      phoneEditingController.text = cleanerProfile.details[i].profile.phoneNumber.toString();
      // dropDownValue ??= cleanerProfile.details[i].profile.status.toString();
    }
  }

  String? selectedGender;

  List<String> genderOptions = ['Male', 'Female', 'Other'];
  String? selectedLang;

  List<String> languageOptions = ['Spanish', 'English'];

  @override
  Widget build(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    // setInitalData(cleanerProfile);

    FetchPixels(context);
    Widget defVerSpaceSet = getVerSpace(FetchPixels.getPixelHeight(20));

    // return _profile();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backGroundColor,
      bottomNavigationBar: saveButton(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defVerSpaceSet,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              child: buildHeader(context),
            ),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
              child: profilePicture(context),
            ),
            buildExpandList(context, defVerSpaceSet),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return gettoolbarMenu(context, 'back.svg', () {
      Constant.backToPrev(context);
    }, istext: true, title: 'Edit Profile'.tr, weight: FontWeight.w900, fontsize: 24, textColor: Colors.black);
  }

  Expanded buildExpandList(BuildContext context, Widget defVerSpaceSet) {
    return Expanded(
      flex: 1,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        primary: true,
        shrinkWrap: true,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getDefaultTextFiledWithLabel(context, 'First Name', firstEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'user.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,
          getDefaultTextFiledWithLabel(context, 'Last Name', lastEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'user.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,
          // getDefaultTextFiledWithLabel(
          //     context, 'Email', emailEditingController, Colors.grey,
          //     function: () {},
          //     height: FetchPixels.getPixelHeight(60),
          //     isEnable: false,
          //     withprefix: true,
          //     image: 'message.svg',
          //     imageWidth: FetchPixels.getPixelHeight(24),
          //     imageHeight: FetchPixels.getPixelHeight(24)),
          // defVerSpaceSet,
          getDefaultTextFiledWithLabel(context, 'Phone', phoneEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'call.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,
          getDefaultTextFiledWithLabel(context, 'Address', addressEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'location.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,
          getDefaultTextFiledWithLabel(context, 'State', stateEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'location.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,
          getDefaultTextFiledWithLabel(context, 'City', cityEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'location.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,
          getDefaultTextFiledWithLabel(context, 'Zip Code', zipEditingController, Colors.grey, function: () {}, height: FetchPixels.getPixelHeight(60), isEnable: false, withprefix: true, image: 'location.svg', imageWidth: FetchPixels.getPixelHeight(24), imageHeight: FetchPixels.getPixelHeight(24)),
          defVerSpaceSet,

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: showShadow ? Colors.white : backGroundColor,
                  boxShadow: showShadow
                      ? const [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
                        ]
                      : null,
                  borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                  border: !showShadow ? Border.all(color: textColor) : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(5),
                    elevation: 15,
                    isExpanded: true,
                    value: selectedGender,
                    dropdownColor: Colors.white,
                    hint: Text(
                      'Select Gender',
                      style: TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: genderOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              defVerSpaceSet,
              Container(
                decoration: BoxDecoration(
                  color: showShadow ? Colors.white : backGroundColor,
                  boxShadow: showShadow
                      ? const [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
                        ]
                      : null,
                  borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
                  border: !showShadow ? Border.all(color: textColor) : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    elevation: 15,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    isExpanded: true,
                    value: selectedLang,
                    hint: Text(
                      'Select Language',
                      style: TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLang = newValue;
                      });
                    },
                    items: languageOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              defVerSpaceSet,
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: showShadow ? Colors.white : backGroundColor,
              boxShadow: showShadow
                  ? const [
                      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
                    ]
                  : null,
              borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              border: !showShadow ? Border.all(color: textColor) : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TimezoneDropdown(
                hintText: 'Select Timezone',
                onTimezoneSelected: (timeZone) => print(timeZone),
              ),
            ),
          ),
          defVerSpaceSet,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Enable Location:'.tr,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Switch(
                value: isLocationEnabled,
                onChanged: (value) {
                  setState(() {
                    isLocationEnabled = value;
                  });
                },
              ),
            ],
          ),
          defVerSpaceSet,
        ],
      ),
    );
  }

  Container saveButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(20), right: FetchPixels.getPixelWidth(20), bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, blueColor, 'Save'.tr, Colors.white, () async {
        await updateProfile();
      }, 18, weight: FontWeight.w600, buttonHeight: FetchPixels.getPixelHeight(60), borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }

  Align profilePicture(BuildContext context) {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: FetchPixels.getPixelHeight(200),
        width: FetchPixels.getPixelHeight(200),
        child: cleanerProfile.details.isNotEmpty
            ? cleanerProfile.details.first.profile.gender.toLowerCase() == 'male'
                ? Lottie.asset('assets/images/male.json')
                : Lottie.asset('assets/images/female.json')
            : Image.asset('assets/images/profile_image.png'),
      ),
    );
  }

  Widget _profile() {
    final cleanerProfile = Provider.of<CleanerDetailsProvider>(context);
    //setInitialData(_cleanerProfile);
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        // backgroundColor: AppColors.AppThemeColor,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.centerRight,
          stops: [0.1, 0.4, 0.6, 0.9],
          colors: [
            Color.fromARGB(255, 68, 73, 221),
            Color.fromARGB(255, 55, 152, 212),
            Color.fromARGB(255, 75, 124, 197),
            Color.fromARGB(255, 177, 190, 238),
          ],
        ))),

        // foregroundColor: Colors.w,
        title: const Text('Edit Profile'),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
                onPressed: () {
                  updateProfile();
                },
                icon: Icon(
                  Icons.check_box,
                  size: 40.0,
                  color: Colors.green[900],
                )),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.centerRight,
          stops: [0.1, 0.4, 0.6, 0.9],
          colors: [
            Color.fromARGB(255, 68, 73, 221),
            Color.fromARGB(255, 55, 152, 212),
            Color.fromARGB(255, 75, 124, 197),
            Color.fromARGB(255, 177, 190, 238),
          ],
        )),
        padding: const EdgeInsets.only(left: 20, top: 20, right: 10, bottom: 10),
        child: Form(
          key: formKey,
          child: ListView.builder(
              itemCount: cleanerProfile.details.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: cleanerProfile
                                        .details[index]
                                        .profile
                                        // ignore: unnecessary_null_comparison
                                        .profilePicture ==
                                    null
                                ? Container(
                                    color: Colors.grey,
                                    child: const Center(
                                        child: Text(
                                      'Not AvailAble',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                    )))
                                : Container(
                                    color: Colors.black,
                                    child: Image.network('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif', fit: BoxFit.fill, errorBuilder: (context, object, stacktrace) {
                                      debugPrint('object : ${object.toString()}');
                                      debugPrint('stacktrace : ${stacktrace.toString()}');
                                      return const Text('Error');
                                    }),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    ///FirstName
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Center(
                            child: Text(
                          'First Name',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        ))),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          initialValue: firstEditingController.text,
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            firstEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                        // height: 15.0,
                        ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 60,
                        child: const Center(
                            child: Text(
                          'Last Name',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        ))),

                    ///LastName
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        //width: MediaQuery.of(context).size.width / 1.54,
                        child: TextFormField(
                          initialValue: lastEditingController.text,
                          //initialValue: _cleanerProfile.details.lastName.toString(),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            lastEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'Status',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     child: DropdownButton(
                    //       // Initial Value
                    //       value: dropDownValue,
                    //
                    //       // Down Arrow Icon
                    //       icon: const Icon(Icons.keyboard_arrow_down),
                    //
                    //       // Array list of items
                    //       items: items.map((String items) {
                    //         return DropdownMenuItem(
                    //           value: items,
                    //           child: Text(items),
                    //         );
                    //       }).toList(),
                    //       // After selecting the desired option,it will
                    //       // change button value to selected value
                    //       onChanged: (String? newValue) {
                    //         setState(() {
                    //           dropDownValue = newValue;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    const SizedBox(
                      height: 15.0,
                    ),

                    ///Email
                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'Email',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        //width: MediaQuery.of(context).size.width / 1.54,
                        child: TextFormField(
                          initialValue: emailEditingController.text,
                          //initialValue: _cleanerProfile.details.email.toString(),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            emailEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    ///ssn
                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'SSN',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        // width: MediaQuery.of(context).size.width / 1.54,
                        child: TextFormField(
                          initialValue: phoneEditingController.text,
                          //initialValue: _cleanerProfile.details.phone.toString(),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            phoneEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    ///Address
                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'Address',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          initialValue: addressEditingController.text,
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            addressEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    ///State

                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'State',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        //width: MediaQuery.of(context).size.width / 1.54,
                        child: TextFormField(
                          initialValue: stateEditingController.text,
                          //initialValue: _cleanerProfile.details.address.toString(),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            stateEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    ///City

                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'Status',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        // width: MediaQuery.of(context).size.width / 1.54,
                        child: TextFormField(
                          initialValue: cityEditingController.text,
                          //initialValue:_cleanerProfile.details.city.toString(),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            cityEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),

                    ///ZipCode

                    Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: MediaQuery.of(context).size.width / 4,
                        child: const Text(
                          'Zip Code',
                          style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        // width: MediaQuery.of(context).size.width / 1.54,
                        child: TextFormField(
                          initialValue: zipEditingController.text,
                          //initialValue: _cleanerProfile.details.zipCode.toString(),
                          decoration: const InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            zipEditingController.text = val;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
