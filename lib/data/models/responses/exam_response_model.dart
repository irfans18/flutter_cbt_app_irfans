import 'package:meta/meta.dart';
import 'dart:convert';

class ExamResponseModel {
  final String message;
  final int timer;
  final List<Datum> data;

  ExamResponseModel({
    required this.message,
    required this.timer,
    required this.data,
  });

  factory ExamResponseModel.fromJson(String str) =>
      ExamResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExamResponseModel.fromMap(Map<String, dynamic> json) =>
      ExamResponseModel(
        message: json["message"],
        timer: json["timer"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "timer": timer,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  final int id;
  final String question;
  final String category;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;

  Datum({
    required this.id,
    required this.question,
    required this.category,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        question: json["question"],
        category: json["category"],
        optionA: json["option_a"],
        optionB: json["option_b"],
        optionC: json["option_c"],
        optionD: json["option_d"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "question": question,
        "category": category,
        "option_a": optionA,
        "option_b": optionB,
        "option_c": optionC,
        "option_d": optionD,
      };
}
