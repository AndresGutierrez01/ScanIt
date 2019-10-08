import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class TextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  TextButton({@required this.text, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(color: AppColors.gray),
        ),
        onPressed: this.onTap,
      ),
    );
  }
}
