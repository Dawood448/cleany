class ChattingListModel {
  ChattingListModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  ChattingListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
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
    this.userId,
    this.userFirstName,
    this.userLastName,
    this.userRole,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.collection,
    this.user,
  });
  int? id;
  int? userId;
  String? userFirstName;
  String? userLastName;
  String? userRole;
  String? message;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  int? collection;
  int? user;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    userRole = json['user_role'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    collection = json['collection'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_first_name'] = userFirstName;
    data['user_last_name'] = userLastName;
    data['user_role'] = userRole;
    data['message'] = message;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['collection'] = collection;
    data['user'] = user;
    return data;
  }
}
