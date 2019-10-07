import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  TextButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text(
          this.text,
          style: TextStyle(color: Colors.black),
        ),
        onPressed: this.onTap,
      ),
    );
  }
}
