import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_cbt_app_irfans/data/models/responses/exam_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api.dart';
import 'auth_local_datasource.dart';

class ExamRemoteDataSource {
  // exam remote datasource
  Future<Either<String, ExamResponseModel>> getExamByCategory(String category) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(
      Uri.parse(Api.getExams + category), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${authData.accessToken}',
    });

    if (response.statusCode == 200) {
      return Right(ExamResponseModel.fromJson(response.body));
    } else {
      return const Left('Get exam failed');
    }
  }

  Future<Either<String, String>> createExam() async{
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(
      Uri.parse(Api.createExam),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}',
      }
    );

    if (response.statusCode == 200) {
      return const Right("Successfully created exam!");
    }else {
      return const Left("Failed to create exam");
    }
  }

  Future<Either<String, String>> setAnswer(int questId, String answer) async{
    final authData = await AuthLocalDataSource().getAuthData();
    final body = {
      "question_id": questId,
      "answer": answer
    };
    final response = await http.post(
      Uri.parse(Api.answer),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return const Right("Successfully answered!");
    }else{
      return const Left("Failed to answer");
    }
  }

  Future<Either<String, String>> countScore(String category) async{
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(
      Uri.parse(Api.score + category),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${authData.accessToken}',
      }
    );

    if (response.statusCode == 200) {
      return const Right("Successfully get score!");
    }else{
      return const Left("Failed to get score");
    }

  }
}
