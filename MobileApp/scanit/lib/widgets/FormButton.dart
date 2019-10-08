import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  FormButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      height: 50,
      width: 1.0 / 0.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: AppColors.mainGradiant,
          begin: FractionalOffset.centerLeft,
          end: FractionalOffset.centerRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.repeated,
        )
      ),
      child: FlatButton(
        onPressed: this.onTap,
        child: Text(
          this.text,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18
          )
        ),
      ),
    );
  }
}
