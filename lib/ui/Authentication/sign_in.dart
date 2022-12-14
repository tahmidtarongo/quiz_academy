import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_academy/repo/auth_repo.dart';
import 'package:quiz_academy/style/app_colors.dart';
import 'package:quiz_academy/style/constant.dart';
import 'package:quiz_academy/ui/Home%20Screen/home.dart';
import 'package:quiz_academy/widgets/button_global.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('images/signin.json'),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Sign in',
                  style: TextStyle(color: AppColor.titleColor, fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    controller: emailEditingController,
                    decoration: myInputDecoration.copyWith(labelText: 'Email Address', hintText: 'Please Enter Your Email Address')),
                const SizedBox(
                  height: 10.0,
                ),
                AppTextField(
                  controller: passwordEditingController,
                    textFieldType: TextFieldType.PASSWORD, decoration: myInputDecoration.copyWith(labelText: 'Password', hintText: 'Please Enter Your Password')),
                const SizedBox(
                  height: 20.0,
                ),
                ButtonGlobal(buttonText: 'Sign In', buttonDecoration: myButtonDecoration, buttonTextColor: Colors.white, onPressed: () async{
                  try{
                    EasyLoading.show(status: 'Signing In..');
                    bool status = await AuthRepo().signInWithEmail(emailEditingController.text, passwordEditingController.text);
                    if(status){
                      Home().launch(context,isNewTask: true);
                      EasyLoading.showSuccess('Sign In Successfully');
                    } else{
                      EasyLoading.showError('Sign in Failed');

                    }
                  }catch(e){
                    EasyLoading.showError(e.toString());
                  }
                }),
                const SizedBox(
                  height: 20.0,
                ),
                ButtonGlobal(buttonText: 'Sign Up', buttonDecoration: myButtonDecoration.copyWith(color: Colors.white,border: Border.all(color: AppColor.mainColor)), buttonTextColor: AppColor.titleColor, onPressed: () {}),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
