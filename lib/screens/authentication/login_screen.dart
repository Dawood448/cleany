import 'dart:async';

import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/screens/home/navbar.dart';
import 'package:cleany/variables/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../base/color_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../../widgets/overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  ValueNotifier valueNotifier = ValueNotifier(true);

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String deviceTokenToSendPushNotification = '';

  @override
  void initState() {
    super.initState();
    getDeviceTokenToSendNotification();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    debugPrint(' Sign in Token Value $deviceTokenToSendPushNotification');
    debugPrint(fcm.subscribeToTopic('all').toString());
    debugPrint(fcm.requestPermission().toString());
  }

  void manageNavigating() async {
    kOverlayWithAsync(asyncFunction: () async{
      int responseVal;
      debugPrint('Managing Navigating');
      debugPrint(deviceTokenToSendPushNotification);
      responseVal = await ApiRequests().getToken(emailEditingController.text,
          passwordEditingController.text, deviceTokenToSendPushNotification);
      debugPrint(responseVal.toString());

      if (responseVal == 200) {
        if (mounted) Navigator.pushNamed(context, AppRoutes.loading);

        // MaterialPageRoute(
        //   builder: (context) => const Navbar(),
        // );
        // Navigator.of(context).pushReplacementNamed(AppRoutes.navbar);

      } else {
        if (mounted)
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Username OR Password')));
      }
      debugPrint(responseVal.toString());
    });

  }

  void signIn() async {
    if (formKey.currentState!.validate()) {
      final email = emailEditingController.text;
      final password = passwordEditingController.text;

      email.isEmpty
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Enter a valid Email')))
          : password.isEmpty
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter a valid Password')))
              : manageNavigating();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backGroundColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            alignment: Alignment.topCenter,
            child: Form(key: formKey, child: buildLoginWidget(context)),
          ),
        ),
      ),
    );
  }

  ListView buildLoginWidget(BuildContext context) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(70)),
        getCustomFont('Login', 24, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont('Glad to meet you again! ', 16, Colors.black, 1,
            fontWeight: FontWeight.w400, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        emailField(context),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        passField(),
        getVerSpace(FetchPixels.getPixelHeight(19)),
        forgotPass(context),
        getVerSpace(FetchPixels.getPixelHeight(49)),
        loginBtn(context),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        dontAcc(context),
        // getVerSpace(FetchPixels.getPixelHeight(50)),
        // getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
        // getVerSpace(FetchPixels.getPixelHeight(50)),
        // btnGoogle(context),
        // getVerSpace(FetchPixels.getPixelHeight(20)),
        // btnFacebook(context),
      ],
    );
  }

  Align forgotPass(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          // TODO: Implement forgot password functionality
          Navigator.pushNamed(context, AppRoutes.loading);
        },
        child: getCustomFont(
          'Forgot Password?',
          16,
          blueColor,
          1,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget btnFacebook(BuildContext context) {
    return getButton(
      context,
      Colors.white,
      'Login with Facebook',
      Colors.black,
      () {},
      18,
      weight: FontWeight.w600,
      isIcon: true,
      image: 'facebook.svg',
      buttonHeight: FetchPixels.getPixelHeight(60),
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
      boxShadow: [
        const BoxShadow(
            color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
      ],
    );
  }

  Widget btnGoogle(BuildContext context) {
    return getButton(
      context,
      Colors.white,
      'Login with Google',
      Colors.black,
      () {},
      18,
      weight: FontWeight.w600,
      isIcon: true,
      image: 'google.svg',
      buttonHeight: FetchPixels.getPixelHeight(60),
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
      boxShadow: [
        const BoxShadow(
            color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
      ],
    );
  }

  Row dontAcc(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCustomFont(
          'Don’t have an account?',
          14,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        GestureDetector(
          onTap: () {
            // TODO: implement sign up functionality
          },
          child: getCustomFont(
            ' Sign Up',
            16,
            blueColor,
            1,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }

  Widget loginBtn(BuildContext context) {
    return getButton(
      context,
      blueColor,
      'Login',
      Colors.white,
      () {
        signIn();
      },
      18,
      weight: FontWeight.w600,
      buttonHeight: FetchPixels.getPixelHeight(60),
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
    );
  }

  ValueListenableBuilder<dynamic> passField() {
    return ValueListenableBuilder(
      builder: (context, value, child) {
        return getDefaultTextFiledWithLabel(
          context,
          'Password',
          passwordEditingController,
          Colors.grey,
          function: () {},
          height: FetchPixels.getPixelHeight(60),
          isEnable: false,
          withprefix: true,
          image: 'lock.svg',
          isPass: valueNotifier.value,
          withSufix: true,
          validator: (val) => val!.isEmpty ? 'Enter Correct Password' : null,
          suffiximage: 'eye.svg',
          imagefunction: () => valueNotifier.value = !valueNotifier.value,
        );
      },
      valueListenable: valueNotifier,
    );
  }

  Widget emailField(BuildContext context) {
    return getDefaultTextFiledWithLabel(
      context,
      'Email',
      emailEditingController,
      Colors.grey,
      function: () {},
      height: FetchPixels.getPixelHeight(60),
      isEnable: false,
      withprefix: true,
      image: 'message.svg',
      imageWidth: FetchPixels.getPixelWidth(19),
      imageHeight: FetchPixels.getPixelHeight(17.66),
      validator: (val) =>
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val!)
              ? null
              : 'Enter Correct email',
    );
  }
}
