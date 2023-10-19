import 'dart:convert';

MessageSendModel messageSendModelFromJson(String str) => MessageSendModel.fromJson(json.decode(str));

String messageSendModelToJson(MessageSendModel data) => json.encode(data.toJson());

class MessageSendModel {
  MessageSendModel({
    this.id,
    this.fromUser,
    this.chatroom,
    this.message,
    this.createdAt,
  });

  int? id;
  int? fromUser;
  int? chatroom;
  String? message;
  DateTime? createdAt;

  factory MessageSendModel.fromJson(Map<String, dynamic> json) => MessageSendModel(
        id: json['id'],
        fromUser: json['from_user'],
        chatroom: json['chatroom'],
        message: json['message'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'from_user': fromUser,
        'chatroom': chatroom,
        'message': message,
        'created_at': createdAt!.toIso8601String(),
      };
}
