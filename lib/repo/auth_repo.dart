import 'dart:convert';

import 'package:quiz_academy/config/config.dart';
import 'package:quiz_academy/repo/database.dart';
import 'package:http/http.dart' as http;

import '../model/user_profile_model.dart';

class AuthRepo{
  Database database = Database();

  Future<bool> signInWithEmail(String email, String password) async{
    String url = AppConfig.serverUrl + AppConfig.signInUrl;
    var response = await http.post(Uri.parse(url),body: <String, dynamic>{
      'email': email,
      'password': password
    });
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      String token = data['data']['token'];
      database.setStringData('token', token);
      return true;
    } else if(response.statusCode == 400){
      throw Exception('Invalid Email or Password');
    } else{
      throw Exception('Something wrong. Please Try again');
    }
  }

  Future<UserProfileModel> userProfileInfo() async {
    Uri url = Uri.parse(AppConfig.serverUrl + AppConfig.userProfileUrl);
    String? token = await database.getStringData('token');
    var response = await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Authorization Failed');
    }
  }

}