import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class ForgotPasswordForm extends StatelessWidget {

  final TextEditingController emailCtr;
  ForgotPasswordForm({
    @required this.emailCtr,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:40, right: 40),
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
        ],
      ),
    );
  }
}