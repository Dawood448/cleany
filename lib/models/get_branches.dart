import 'dart:convert';

GetBranchesModel getBranchesFromJson(String str) => GetBranchesModel.fromJson(json.decode(str));

String getBranchesToJson(GetBranchesModel data) => json.encode(data.toJson());

class GetBranchesModel {
  GetBranchesModel({
    required this.branches,
  });

  List<Branch> branches;

  factory GetBranchesModel.fromJson(Map<String, dynamic> json) => GetBranchesModel(
        branches: List<Branch>.from(json['branches'].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'branches': List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  Branch({
    this.id,
    this.title,
    this.uri,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? uri;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json['id'],
        title: json['title'],
        uri: json['uri'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'uri': uri,
        'created_at': createdAt!.toIso8601String(),
        'updated_at': updatedAt!.toIso8601String(),
      };
}
