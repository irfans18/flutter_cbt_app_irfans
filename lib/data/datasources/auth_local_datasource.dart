import 'package:flutter_cbt_app_irfans/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', authResponseModel.toJson());
  }

  Future<AuthResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final authData = pref.getString('auth_data');
    print("Auth data: $authData");
    return AuthResponseModel.fromJson(authData!);
  }

  Future<void> deleteAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
    print("Berhasil remove");
  }
}
