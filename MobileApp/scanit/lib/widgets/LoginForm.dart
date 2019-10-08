import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class LoginForm extends StatelessWidget {

  final TextEditingController emailCtr;
  final TextEditingController passwordCtr;
  LoginForm({
    @required this.emailCtr,
    @required this.passwordCtr
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        children: <Widget>[
          TextField(
            controller: this.emailCtr,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail_outline, color: AppColors.gray,),
              hintText: "Email",
              hintStyle: TextStyle(color: AppColors.gray),
              border: InputBorder.none
            ),
          ),
          Divider(color: AppColors.gray, height: 0,),
          Padding(padding: EdgeInsets.all(10),),
          TextField(
            controller: this.passwordCtr,
            obscureText: true,
            style: TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.gray,),
              hintText: "Password",
              hintStyle: TextStyle(color: AppColors.gray),
              border: InputBorder.none
            ),
          ),
          Divider(color: AppColors.gray, height: 0,),
        ],
      ),
    );
  }
}