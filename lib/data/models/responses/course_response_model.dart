import 'package:meta/meta.dart';
import 'dart:convert';

class CourseResponseModel {
  final String status;
  final List<Course> data;

  CourseResponseModel({
    required this.status,
    required this.data,
  });

  factory CourseResponseModel.fromJson(String str) =>
      CourseResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseResponseModel.fromMap(Map<String, dynamic> json) =>
      CourseResponseModel(
        status: json["status"],
        data: List<Course>.from(json["data"].map((x) => Course.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Course {
  final int id;
  final String title;
  final String content;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Course({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(String str) => Course.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
