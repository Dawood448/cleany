class NotificationListModel {
  NotificationListModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'].length == null ? null : (json['data'] as List).map((e) => Data.fromJson(e)).toList();
    //  List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    data['data'] = this.data!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  Data({
    this.id,
    this.bookingId,
    this.user,
    this.title,
    this.markAsRead,
    this.createdAt,
    this.updatedAt,
    this.bod,
  });
  int? id;
  int? bookingId;
  User? user;
  String? title;
  bool? markAsRead;
  String? createdAt;
  String? updatedAt;
  int? bod;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    user = User.fromJson(json['user']);
    title = json['title'];
    markAsRead = json['mark_as_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bod = json['bod'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['booking_id'] = bookingId;
    data['user'] = user!.toJson();
    data['title'] = title;
    data['mark_as_read'] = markAsRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bod'] = bod;
    return data;
  }
}

class User {
  User({
    this.id,
    this.email,
    this.userProfile,
  });
  int? id;
  String? email;
  UserProfile? userProfile;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userProfile = UserProfile.fromJson(json['user_profile']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['user_profile'] = userProfile!.toJson();
    return data;
  }
}

class UserProfile {
  UserProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.role,
  });
  int? id;
  String? firstName;
  String? lastName;
  String? role;

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['role'] = role;
    return data;
  }
}
