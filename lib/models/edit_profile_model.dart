
import 'dart:convert';

CleanerProfileModel cleanerProfileFromJson(String str) => CleanerProfileModel.fromJson(json.decode(str));

String cleanerProfileToJson(CleanerProfileModel data) => json.encode(data.toJson());

class CleanerProfileModel {
  CleanerProfileModel({
    this.id,
    this.email,
    this.passwordPlainDev,
    this.status,
    this.firstName,
    this.lastName,
    this.photo,
    this.the1099,
    this.ssn,
    this.address,
    this.city,
    this.zipCode,
    this.state,
    this.phone,
    this.country,
    this.gender,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? email;
  String? passwordPlainDev;
  String? status;
  String? firstName;
  String? lastName;
  String? photo;
  dynamic the1099;
  int? ssn;
  String? address;
  String? city;
  String? zipCode;
  String? state;
  String? phone;
  String? country;
  String? gender;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? user;

  factory CleanerProfileModel.fromJson(Map<String, dynamic> json) => CleanerProfileModel(
        id: json['id'],
        email: json['email'],
        passwordPlainDev: json['password_plain_dev'],
        status: json['status'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        photo: json['photo'],
        the1099: json['_1099'],
        ssn: json['ssn'],
        address: json['address'],
        city: json['city'],
        zipCode: json['zip_code'],
        state: json['state'],
        phone: json['phone'],
        country: json['country'],
        gender: json['gender'],
        language: json['language'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        user: json['user'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password_plain_dev': passwordPlainDev,
        'status': status,
        'first_name': firstName,
        'last_name': lastName,
        'photo': photo,
        '_1099': the1099,
        'ssn': ssn,
        'address': address,
        'city': city,
        'zip_code': zipCode,
        'state': state,
        'phone': phone,
        'country': country,
        'gender': gender,
        'language': language,
        'created_at': createdAt!.toIso8601String(),
        'updated_at': updatedAt!.toIso8601String(),
        'user': user,
      };
}
