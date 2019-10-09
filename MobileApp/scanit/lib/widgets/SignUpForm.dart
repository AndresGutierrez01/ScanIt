import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController emailCtr;
  final TextEditingController passwordCtr;
  final TextEditingController passwordConfirmCtr;
  SignUpForm(
      {@required this.emailCtr,
      @required this.passwordCtr,
      @required this.passwordConfirmCtr});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40,right: 40),
      child: Column(
        children: <Widget>[
          TextField(
            controller: this.emailCtr,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: AppColors.white),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: AppColors.gray,
                ),
                hintText: "Email",
                hintStyle: TextStyle(color: AppColors.gray),
                border: InputBorder.none),
          ),
          Divider(
            color: AppColors.gray,
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          TextField(
            controller: this.passwordCtr,
            obscureText: true,
            style: TextStyle(color: AppColors.white),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: AppColors.gray,
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: AppColors.gray),
                border: InputBorder.none),
          ),
          Divider(
            color: AppColors.gray,
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          TextField(
            controller: this.passwordConfirmCtr,
            obscureText: true,
            style: TextStyle(color: AppColors.white),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppColors.gray,
                ),
                hintText: "Confirm Password",
                hintStyle: TextStyle(color: AppColors.gray),
                border: InputBorder.none),
          ),
          Divider(
            color: AppColors.gray,
            height: 0,
          ),
        ],
      ),
    );
  }
}
