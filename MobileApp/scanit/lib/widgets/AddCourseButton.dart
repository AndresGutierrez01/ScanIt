import 'package:flutter/material.dart';

class AddCourseButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  AddCourseButton({@required this.text, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: this.onTap,
        label: Text('Approve'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
