import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api.dart';
import '../models/responses/content_response_model.dart';
import 'auth_local_datasource.dart';

class ContentRemoteDataSource {
  // get content by id
  Future<Either<String, ContentResponseModel>> getContentById(int id) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(
      Uri.parse('${Api.contents}/?id=$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return Right(ContentResponseModel.fromJson(response.body));
    } else {
      return Left('Get content failed');
    }
  }
}
