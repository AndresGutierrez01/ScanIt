import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';

class GradeTile extends StatelessWidget {
  final DocumentSnapshot grade;

  GradeTile({@required this.grade});

  Widget build(context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                grade.data['name'],
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Text(
                grade.data['email'],
                style: TextStyle(color: AppColors.aqua),
              ),
            ],
          ),
        ),
        Text(
          '97%',
          style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        )
      ]),
    );
  }
}
