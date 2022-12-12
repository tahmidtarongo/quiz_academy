import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_academy/style/app_colors.dart';
import 'package:quiz_academy/ui/Authentication/sign_in.dart';

import '../../style/constant.dart';
import '../../widgets/button_global.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('images/welcome.json'),
            SizedBox(
              height: 20.0,
            ),
            const Text(
              'Please Sign Up Or Login\n To Continue',
              style: TextStyle(
                color: AppColor.titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0,),
            ButtonGlobal(
              buttonText: 'Sign In',
              buttonTextColor: Colors.white,
              buttonDecoration: myButtonDecoration,
              onPressed: ()=> const SignIn().launch(context),
            ),
            SizedBox(height: 10.0,),
            ButtonGlobal(
              buttonText: 'Sign Up',
              buttonTextColor: AppColor.titleColor,
              buttonDecoration: myButtonDecoration.copyWith(color: Colors.white),
              onPressed: (){

              },
            ),
          ],
        ),
      ),
    );
  }
}
