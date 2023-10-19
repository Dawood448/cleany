import 'package:cleany/apis/request_apis.dart';
import 'package:cleany/models/cleaner_profile_model.dart';
import 'package:flutter/widgets.dart';

class CleanerDetailsProvider with ChangeNotifier {
  List<CleanerProfileModel1> details = [];
  bool loading = false;

  //var token = Authentication.token();

  getDetails(context) async {
    // loading = true;
    details = (await ApiRequests().getProfileDetailsApi());
    // loading = false;

    notifyListeners();
  }

  void clearDetails() {
    details.clear();
    notifyListeners();
  }
}
