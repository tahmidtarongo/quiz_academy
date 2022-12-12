import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_academy/style/app_colors.dart';
import 'package:quiz_academy/ui/Authentication/welcome_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> init()async {
    await Future.delayed(const Duration(seconds: 2)).then((value) => const WelcomeScreen().launch(context,isNewTask: true,pageRouteAnimation: PageRouteAnimation.Slide));
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
