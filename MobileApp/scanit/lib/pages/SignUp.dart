import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/MainBanner.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MainBanner(),
                Padding(padding: EdgeInsets.all(20),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}