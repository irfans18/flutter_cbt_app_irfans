import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api.dart';
import '../models/requests/register_request_model.dart';
import '../models/responses/auth_response_model.dart';

class AuthRemoteDataSource {
  Future<Either<String, AuthResponseModel>> register(RegisterRequestModel registerRequestModel) async{
    final response = await http.post(
      Uri.parse(Api.register),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: registerRequestModel.toJson(),
    );

    if (response.statusCode == 201) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }
}