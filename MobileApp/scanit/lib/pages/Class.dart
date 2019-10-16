import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';


class Class extends StatefulWidget {
  final String title;
  final String id;

  Class({
    @required this.title,
    @required this.id,
  });

  @override
  _ClassState createState() => _ClassState();
}

class _ClassState extends State<Class> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: AppColors.background,
        child: Center(child: Text(widget.id),),
      ),
    );
  }
}