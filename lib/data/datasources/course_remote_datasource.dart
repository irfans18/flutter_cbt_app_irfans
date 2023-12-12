import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api.dart';
import '../models/responses/course_response_model.dart';
import 'auth_local_datasource.dart';

class CourseRemoteDataSource {
  Future<Either<String, CourseResponseModel>> getAllCourses() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(
      Uri.parse(Api.courses),
      headers: <String, String>{
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return Right(CourseResponseModel.fromJson(response.body));
    } else {
      return Left('Get courses failed');
    }
  }
}
