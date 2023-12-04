import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api.dart';
import '../models/requests/login_request_model.dart';
import '../models/requests/register_request_model.dart';
import '../models/responses/auth_response_model.dart';
import 'auth_local_datasource.dart';

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
      return left('Register failed');
    }
  }

  // implement login
  Future<Either<String, AuthResponseModel>> login(LoginRequestModel loginRequestModel) async {
    final response = await http.post(
      Uri.parse(Api.login),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: loginRequestModel.toJson(),
    );

    if(response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left('Login failed');
    }
  }

  // implement logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.post(
      Uri.parse(Api.logout),
      headers: <String,String>{
        'Authorization': 'Bearer ${authData.accessToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode == 200) {
      return right(response.body);
    } else {
      return left('Logout failed');
    }
  }
}