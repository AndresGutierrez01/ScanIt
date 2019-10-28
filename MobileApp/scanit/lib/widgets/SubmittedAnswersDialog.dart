import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:scanit/utilites/AppColors.dart';

class SubmittedAnswersDialog extends StatelessWidget {
  final List<String> submission;
  SubmittedAnswersDialog({@required this.submission});

  _columnBuilder(int start, [int finish]) {
    if (start > submission.length) {
      return [Container()];
    }

    List<Widget> submissionCol = <Widget>[];
    submission
        .sublist(start, math.min(finish ?? 20, submission.length))
        .asMap()
        .forEach((index, s) {
      submissionCol.add(
        Text(
          "${start + index + 1}: $s",
          style: TextStyle(color: AppColors.aqua),
        ),
      );
    });
    return submissionCol;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: Text(
        'Submission',
        style: TextStyle(color: AppColors.white),
      ),
      content: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment(0, 0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _columnBuilder(0, 10)),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _columnBuilder(10)),
                    )
                  ]))),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.greenAccent),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
