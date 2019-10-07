import 'package:flutter/material.dart';
import '../utilites/AppColors.dart';

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  FormButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50),
      decoration: BoxDecoration(
        color: AppColors.greenAccent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: FlatButton(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.black),
          ),
          onPressed: this.onTap),
    );
  }
}
