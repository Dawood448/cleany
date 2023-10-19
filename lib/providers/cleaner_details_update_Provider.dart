//
// import 'package:cleany/apis/request_apis.dart';
// import 'package:cleany/models/edit_profile_model.dart';
// import 'package:cleany/models/cleaner_profile_model.dart';
// import 'package:flutter/material.dart';
//
// class CleanerDetailsUpdateProvider with ChangeNotifier {
//    EditProfileModel update = EditProfileModel();
//   //CleanerProfileModel details = CleanerProfileModel();
//   bool loading = false;
//
//   //var token = Authentication.token();
//
//   updateDetails(context,email, firstName, lastName, phone, address, city, zip, ssn, state) async {
//     loading = true;
//      update = await ApiRequests().patchProfileDetailsApi(email, firstName, lastName, phone, address, city, zip, ssn, state);
//     loading = false;
//
//     notifyListeners();
//   }
// }
