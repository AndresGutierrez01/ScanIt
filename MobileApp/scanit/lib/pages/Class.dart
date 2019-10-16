import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/widgets/FormButton.dart';


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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: AppColors.aqua,
            tabs: <Widget>[
              Tab(text: "Tests"),
              Tab(text: "Students",)
            ],
          ),
          title: Text(widget.title, style: TextStyle(color: AppColors.aqua),),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              color: AppColors.background,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  FormButton(
                    text: ("Create Test"),
                    onTap: ()=>{},
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              color: AppColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  FormButton(
                    text: ("Add Student"),
                    onTap: ()=>{},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}