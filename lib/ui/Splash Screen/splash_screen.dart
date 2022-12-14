import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_academy/repo/database.dart';
import 'package:quiz_academy/style/app_colors.dart';
import 'package:quiz_academy/ui/Authentication/welcome_screen.dart';
import 'package:quiz_academy/ui/Home%20Screen/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Database database = Database();
  Future<void> init()async {
    await Future.delayed(const Duration(seconds: 2)).then((value) async{
      String? token = await database.getStringData('token');
      if(token.isEmptyOrNull){
        WelcomeScreen().launch(context,isNewTask: true);
      } else
        {
          Home().launch(context,isNewTask: true);
        }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Center(
        child: CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.white,
          child: Lottie.asset('images/quiz.json'),
        ),
      ),
    );
  }
}
