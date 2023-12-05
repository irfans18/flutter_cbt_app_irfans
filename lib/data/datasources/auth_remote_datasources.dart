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

    print(response.body);
    print("STATUS CODE : " + response.statusCode.toString());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left('Register failed');
    }
  }

  // implement login
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel data) async {
    final response =
        await http.post(Uri.parse(Api.login),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: data.toJson());

    print(response.body);
    print("STATUS CODE : "+response.statusCode.toString());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('login gagal');
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
      return Right(response.body);
    } else {
      return Left('Logout failed');
    }
  }
}