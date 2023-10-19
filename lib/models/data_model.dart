import 'dart:convert';

class Data {
  int id;
  String start;
  String end;
  String title;
  String createdAt;
  String updatedAt;
  int serviceProvider;
  Data({
    required this.id,
    required this.start,
    required this.end,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceProvider,
  });

  Data copyWith({
    int? id,
    String? start,
    String? end,
    String? title,
    String? createdAt,
    String? updatedAt,
    int? serviceProvider,
  }) {
    return Data(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serviceProvider: serviceProvider ?? this.serviceProvider,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start': start,
      'end': end,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'serviceProvider': serviceProvider,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id']?.toInt() ?? 0,
      start: map['start'] ?? '',
      end: map['end'] ?? '',
      title: map['title'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      serviceProvider: map['serviceProvider']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(id: $id, start: $start, end: $end, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, serviceProvider: $serviceProvider)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.id == id &&
        other.start == start &&
        other.end == end &&
        other.title == title &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.serviceProvider == serviceProvider;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        start.hashCode ^
        end.hashCode ^
        title.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        serviceProvider.hashCode;
  }
}
