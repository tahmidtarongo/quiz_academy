import 'package:flutter/material.dart';

import '../style/app_colors.dart';
class ButtonGlobal extends StatelessWidget {
  ButtonGlobal({
    Key? key,
    required this.buttonText,
    required this.buttonDecoration,
    required this.buttonTextColor,
    required this.onPressed
  }) : super(key: key);
  final String buttonText;
  final Decoration buttonDecoration;
  final Color buttonTextColor;
  var onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        decoration: buttonDecoration,
        child: Center(child: Text(buttonText,style: TextStyle(color: buttonTextColor,fontWeight: FontWeight.bold,fontSize: 18.0),)),
      ),
    );
  }
}