class ApiResponse {
  ApiResponse({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'].length == null ? null : (json['data'] as List).map((e) => Data.fromJson(e)).toList();

    // List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    data['data'] = this.data == null ? null : this.data!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  Data({
    required this.id,
    required this.start,
    required this.end,
    this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceProvider,
  });
  int? id;
  String? start;
  String? end;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? serviceProvider;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceProvider = json['service_provider'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['start'] = start;
    data['end'] = end;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['service_provider'] = serviceProvider;
    return data;
  }
}
