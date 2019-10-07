import 'package:flutter/material.dart';
import '../utilites/AppColors.dart';

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  FormButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
      height: 50,
      width: 1.0 / 0.0,
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
