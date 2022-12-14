import 'dart:convert';

import 'package:quiz_academy/config/config.dart';
import 'package:quiz_academy/repo/database.dart';
import 'package:http/http.dart' as http;
import '../model/Quiz_model.dart';

class QuizRepo{
  Database database = Database();

  Future<QuizModel> getQuiz() async{
    String url = AppConfig.serverUrl + AppConfig.quizUrl;
    String token = await database.getStringData('token');
    var response= await http.get(Uri.parse(url),headers: <String, String>{
      'Authorization': 'Bearer $token'
    });
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return QuizModel.fromJson(data);
    } else if(response.statusCode == 401){
      throw Exception('Please login First');
    } else{
      throw Exception('Unknown Error Occurred. Please Try Again');
    }
  }
}