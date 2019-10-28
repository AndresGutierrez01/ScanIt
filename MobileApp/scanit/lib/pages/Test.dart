import 'package:flutter/material.dart';
import 'package:scanit/pages/EditKey.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';

class Test extends StatefulWidget {
  final String testId;
  final String classId;
  final String name;

  Test({@required this.testId, @required this.classId, @required this.name});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    editKey() {
      Navigator.of(context).push(
        SlideRightRoute(
            widget: EditKey(classId: widget.classId, testId: widget.testId)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: <Widget>[
          IconButton(
            onPressed: editKey,
            icon: Icon(
              Icons.vpn_key,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
