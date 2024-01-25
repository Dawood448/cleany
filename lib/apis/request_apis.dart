import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cleany/auth/auth.dart';
import 'package:cleany/models/booking_details_model.dart';
import 'package:cleany/models/chat_list_model.dart';
import 'package:cleany/models/chat_room.dart';
import 'package:cleany/models/cleaner_profile_model.dart';
import 'package:cleany/models/notification_list_model.dart';
import 'package:cleany/models/response_get_leaves.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../models/analytics.dart';
import '../models/cleany_tips_model.dart';
import '../models/review_model.dart';

class ApiRequests {
  // Future getBranches() async {
  //   List<GetBranchesModel> _getBranches = [];
  //   try {
  //     String url = "http://159.89.203.65/api/v1/cleany/branches/";
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'accept': 'application/json',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       _getBranches.add(GetBranchesModel.fromJson(responseData));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return _getBranches.first.branches;
  // }

  Future startShift(String id, String isSick, String workMood) async {
    var token = await Authentication.token();

    try {
      String url = 'https://dev.bookcleany.com/mobile_side/schedule/shift/start/';
      final response = await http.patch(Uri.parse(url), headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        //'accept': 'application/json',
      }, body: {
        'schedule_id': id,
        'is_sick': isSick,
        'work_mood': workMood
      });
      debugPrint(response.statusCode.toString());
      debugPrint(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // print(responseData.toString());
        debugPrint(responseData.toString());
        debugPrint('START SHIFT : SUCCESSFUL');
      }
      return response.statusCode.toString();
    } catch (e) {
      log(e.toString());
    }
  }

  Future pushLocation(String latitude, String longitude) async {
    var token = await Authentication.token();
    debugPrint('IN PUSH LOCATION');
    debugPrint(latitude);
    debugPrint(longitude);
    try {
      String url = 'https://dev.bookcleany.com/user_module/update_cleaner_location';
      final response = await http.post(Uri.parse(url), headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        'latitude': latitude,
        'longitude': longitude
      });

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        debugPrint(responseData.toString());
      }
      return response.statusCode.toString();
    } catch (e) {
      log(e.toString());
    }
  }

  Future endShift(String id, String taskscomplete, String comments) async {
    var token = await Authentication.token();

    try {
      String url = 'https://dev.bookcleany.com/mobile_side/schedule/shift/end/';
      final response = await http.patch(Uri.parse(url), headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        //'accept': 'application/json',
      }, body: {
        'schedule_id': id,
        'tasks_complete': taskscomplete,
        'comments': comments,
      });
      debugPrint(response.statusCode.toString());
      debugPrint(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // print(responseData.toString());
      }
      return response.statusCode.toString();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<CleanerProfileModel1>> getProfileDetailsApi() async {
    // CleanerProfileModel1 getDetails = CleanerProfileModel1();
    List<CleanerProfileModel1> getDetails = [];
    var token = await Authentication.token();
    try {
      String url = 'https://dev.bookcleany.com/mobile_side/cleaner/profile/';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-CSRFToken': 'LgZ9UELbb4wg8dQJkJeCSHXBEU30Id6ctfeV1ko4qzBhhsyxWD77znCeIX1ucXY0',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        getDetails.add(CleanerProfileModel1.fromJson(responseData));
      }
    } catch (e) {
      log(e.toString());
    }
    return getDetails;
  }

  Future<ChatRoom> getChatsApi(var roomId) async {
    ChatRoom chattingDetailsModel = ChatRoom();
    ChatRoom chattingDetails;
    var token = await Authentication.token();

    String url = 'https://dev.bookcleany.com/booking/get_booking_chat/$roomId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        //'accept': 'application/json',
      },
    );

    chattingDetailsModel = ChatRoom.fromJson(jsonDecode(response.body));
    chattingDetails = chattingDetailsModel;

    return chattingDetails;
  }

  Future<List<BookingDetailsModel>> getBookingetailsApi() async {
    BookingDetailsModel bookingDetailsModel = BookingDetailsModel();
    BookingDetailsModel? bookingDetails;
    List<BookingDetailsModel> bookings = [];

    var token = await Authentication.token();
    try {
      String url = 'https://dev.bookcleany.com/booking/cleaner_booking_listing';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-CSRFToken': token,
        },
      );
      if (response.statusCode == 200) {
        // log('${response.body}');
        bookingDetailsModel = BookingDetailsModel.fromJson(jsonDecode(response.body));
        print('-------response2-----${bookingDetailsModel.data!.length}');
        bookingDetails = bookingDetailsModel;

        for (int i = 0; i < bookingDetails.data!.length; i++) {
          bookings.add(bookingDetails);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return bookings;
  }

  Future<BookingDetailsData> getBookingDetailApi(int id) async {
    BookingDetailsModel bookingDetailsModel = BookingDetailsModel();
    var token = await Authentication.token();
    try {
      String url = 'https://dev.bookcleany.com/booking/booking_details/$id';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-CSRFToken': token,
        },
      );
      if (response.statusCode == 200) {
        // log('${response.body}');
        bookingDetailsModel = BookingDetailsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    return bookingDetailsModel.data!.first;
  }

  Future<List<TipsData>> getTipsList(int id) async {
    TipsModel tipsModel = TipsModel();
    List<TipsData> tips = [];
    var token = await Authentication.token();
    try {
      String url = 'https://dev.bookcleany.com/booking/list-charge-tips/?cleaner_id=$id';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-CSRFToken': token,
        },
      );
      if (response.statusCode == 200) {
        // log('${response.body}');
        tipsModel = TipsModel.fromJson(jsonDecode(response.body));
        print('-------response2-----${tipsModel.data!.length}');

        for (int i = 0; i < tipsModel.data!.length; i++) {
          tips.addAll(tipsModel.data!);
        }
        return tips;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future getChatListApi() async {
    ChattingListModel chattingListModel = ChattingListModel();
    ChattingListModel chattingList;
    List<ChattingListModel> chat = [];
    var token = await Authentication.token();
    try {
      String url = 'https://dev.bookcleany.com/booking/get_cleaner_chat';
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-CSRFToken': token,
        },
      );

      if (response.statusCode == 200) {
        chattingListModel = ChattingListModel.fromJson(jsonDecode(response.body));
        chattingList = chattingListModel;
        for (int i = 0; i < chattingList.data!.length; i++) {
          chat.add(chattingList);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return chat;
  }

  Future getLeaveList() async {
    ApiResponse apiResponse = ApiResponse();
    ApiResponse finalApi;
    List<ApiResponse> getLeaves = [];
    var token = await Authentication.token();
    var userId = await Authentication.userId();
    try {
      final headers = <String, String>{'accept': 'application/json', 'X-CSRFToken': '0qSRty1Z16aa8cPGpXJy8DvUIEtVcCFJ68eICrOCjNnn4MiQpNrWHPdwDPwX5YYp', 'Authorization': 'Bearer $token'};
      final response = await http.get(Uri.parse('https://dev.bookcleany.com/service_provider/list_leaves?service_provider=$userId'), headers: headers);
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
        finalApi = apiResponse;
        for (int i = 0; i < finalApi.data!.length; i++) {
          getLeaves.add(finalApi);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return getLeaves;
  }

  Future getNotificationList() async {
    NotificationListModel notificationListModel = NotificationListModel();
    var token = await Authentication.token();
    NotificationListModel notificationList;
    List<NotificationListModel> notification = [];

    try {
      final headers = <String, String>{'accept': 'application/json', 'X-CSRFToken': '0qSRty1Z16aa8cPGpXJy8DvUIEtVcCFJ68eICrOCjNnn4MiQpNrWHPdwDPwX5YYp', 'Authorization': 'Bearer $token'};
      final response = await http.get(Uri.parse('https://dev.bookcleany.com/booking/notifications'), headers: headers);
      if (response.statusCode == 200) {
        notificationListModel = NotificationListModel.fromJson(jsonDecode(response.body));
        notificationList = notificationListModel;
        for (int i = 0; i < notificationList.data!.length; i++) {
          notification.add(notificationList);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return notification;
  }

  Future patchProfileDetailsApi({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String city,
    required String zip,
    required String ssn,
    required String state,
    String? status,
    required String gender,
    required String language,
    required String timezone,
    required String location,
    required String country,
    required String profile,
  }) async {
    var token = await Authentication.token();

    var responseStatus;
    // try {
    String url = 'https://dev.bookcleany.com/user_module/update_profile';
    final response = await http.put(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
      // 'X-CSRFToken': 'LgZ9UELbb4wg8dQJkJeCSHXBEU30Id6ctfeV1ko4qzBhhsyxWD77znCeIX1ucXY0',
      //'accept': 'application/json',
    }, body: {
      'gender': gender,
      'language': language,
      'first_name': firstName,
      'last_name': lastName,
      'time_zone': timezone,
      'email': email,
      'phone_number': ssn,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zip,
      'country': country,
      // 'profile_picture': profile,
      'location': location,
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      responseStatus = response.statusCode.toString();
    }
    print(jsonDecode(response.body));
    return responseStatus;
  }

  Future updateProfilePicture(profilePicture) async {
    print(profilePicture);
    final Uri uri = Uri.parse('https://dev.bookcleany.com/user_module/update_profile');

    try {
      var request = http.MultipartRequest('PUT', uri);
      request.fields['profile_picture'] = '$profilePicture';

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Profile picture updated successfully');
      } else {
        print('Failed to update profile picture. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating profile picture: $error');
    }
  }

  Future<int> getToken(String email, String password, String deviceToken) async {
    String url = 'https://dev.bookcleany.com/user_module/mobile_login';
    final response = await http.post(Uri.parse(url), headers: {
      'accept': 'application/json',
    }, body: {
      'email': email,
      'password': password,
      'device_token': deviceToken,
    });
    var responseData = json.decode(response.body);
    var tokens = responseData['access_token'];
    var userId = responseData['user_id'];
    FirebaseMessaging.instance.subscribeToTopic('cleany_$userId');

    debugPrint(getToken.toString());
    try {
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();

        await storage.write(key: 'jwt', value: tokens.toString());
        await storage.write(key: 'userid', value: userId.toString());
        debugPrint(responseData);

        return response.statusCode;
      } else {
        debugPrint(response.statusCode.toString());
        return response.statusCode;
      }
    } catch (e) {
      return response.statusCode;
    }
  }

  Future postMessage(String msg, String chatRoomId) async {
    String url = 'https://dev.bookcleany.com/booking/admin_chat';
    var token = await Authentication.token();

    Map<String, String> headers = {'accept': 'application/json', 'Content-Type': 'application/json', 'X-CSRFToken': 'x3LA45wJiaBHySdMgSBPzJDt7PaAez3tbtD6JpxKTvCttuF4DrsbzjJl6aAELUf5', 'Authorization': 'Bearer $token'};
    final body = jsonEncode({'collection': chatRoomId.toString(), 'message': msg.toString()});

    debugPrint('Message Body: $body}');

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    debugPrint('Message Response: ${response.body}');

    try {
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {}
    } catch (e) {
      return response.statusCode;
    }
  }

  Future deleteLeave(int? id) async {
    String url = 'https://dev.bookcleany.com/service_provider/delete_leave/$id';
    var token = await Authentication.token();
    var userId = await Authentication.userId();
    debugPrint('MMMMMMMMMMMMMMMMM');
    debugPrint(userId);

    final response = await http.delete(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Authorization': 'Token $token',
    });
    var responseData = json.decode(response.body);
    debugPrint(responseData.toString());

    try {
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      return response.statusCode;
    }
  }

  Future postLeave(String startDateTime, String endDateTime, String title) async {
    String url = 'https://dev.bookcleany.com/service_provider/create_leave';
    var token = await Authentication.token();
    var userId = await Authentication.userId();

    debugPrint(userId);

    final response = await http.post(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Authorization': 'Token $token',
    }, body: {
      'start': startDateTime,
      'end': endDateTime,
      'title': title,
      'service_provider': userId,
    });
    var responseData = json.decode(response.body);

    try {
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      return response.statusCode;
    }
  }

  Future<List<ReviewModel>> getReviews() async {
    var token = await Authentication.token();
    List<ReviewModel> reviews = [];
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    var response = await http.get(
      Uri.parse('https://dev.bookcleany.com/user_module/cleaner_reviews_list?review_type=Cleaner'),
      headers: headers,
    );

    ReviewDataModel reviewDataModel = reviewDataModelFromJson(response.body);
    reviewDataModel.data?.forEach((element) {
      reviews.add(element);
    });
    return reviews;
    // request.headers.addAll(headers);
  }

  Future<AnalyticsModel> fetchCleanerData(int cleanerId) async {
    var token = await Authentication.token();
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final String apiUrl = 'https://dev.bookcleany.com/service_provider/cleaner-analytics/?cleaner_id=$cleanerId';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      AnalyticsModel analyticsModel = AnalyticsModel.fromJson(json.decode(response.body));
      return analyticsModel;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
