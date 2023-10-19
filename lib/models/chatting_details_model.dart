// To parse this JSON data, do
//
//     final chattingDetailsModel = chattingDetailsModelFromJson(jsonString);

import 'dart:convert';

List<ChattingDetailsModel> chattingDetailsModelFromJson(String str) =>
    List<ChattingDetailsModel>.from(json.decode(str).map((x) => ChattingDetailsModel.fromJson(x)));

String chattingDetailsModelToJson(List<ChattingDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChattingDetailsModel {
  ChattingDetailsModel({
    this.id,
    this.fromUserId,
    this.fromUserName,
    this.chatroomId,
    this.message,
    this.createdAt,
  });

  int? id;
  int? fromUserId;
  String? fromUserName;
  int? chatroomId;
  String? message;
  DateTime? createdAt;

  factory ChattingDetailsModel.fromJson(Map<dynamic, dynamic> json) => ChattingDetailsModel(
        id: json['id'],
        fromUserId: json['from_user_id'],
        fromUserName: json['from_user_name'],
        chatroomId: json['chatroom_id'],
        message: json['message'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'from_user_id': fromUserId,
        'from_user_name': fromUserName,
        'chatroom_id': chatroomId,
        'message': message,
        'created_at': createdAt!.toIso8601String(),
      };
}
