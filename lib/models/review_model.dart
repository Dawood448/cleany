// To parse this JSON data, do
//
//     final reviewDataModel = reviewDataModelFromJson(jsonString);

import 'dart:convert';

ReviewDataModel reviewDataModelFromJson(String str) =>
    ReviewDataModel.fromJson(json.decode(str));

String reviewDataModelToJson(ReviewDataModel data) =>
    json.encode(data.toJson());

class ReviewDataModel {
  ReviewDataModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? message;
  List<ReviewModel>? data;

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) =>
      ReviewDataModel(
        success: json["success"],
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ReviewModel>.from(
                json["data"]!.map((x) => ReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReviewModel {
  ReviewModel({
    this.id,
    this.reviewType,
    this.rating,
    this.review,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.cleaner,
    this.service,
  });

  int? id;
  String? reviewType;
  int? rating;
  String? review;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? customer;
  int? cleaner;
  dynamic service;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        reviewType: json["review_type"],
        rating: json["rating"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customer: json["customer"],
        cleaner: json["cleaner"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review_type": reviewType,
        "rating": rating,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer": customer,
        "cleaner": cleaner,
        "service": service,
      };
}
