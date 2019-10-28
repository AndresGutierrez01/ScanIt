import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  final String testId;
  final String classId;
  final String name;

  Test({
    @required this.testId,
    @required this.classId,
    @required this.name
  });

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
    );
  }
}