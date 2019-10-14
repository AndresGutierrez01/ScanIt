import 'package:flutter/material.dart';
import 'package:scanit/pages/Login.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/Auth.dart';
import 'package:scanit/widgets/SlideLeftRoute.dart';

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  choiceAction(value) {
    if (value == 0) {
      print("creating class");
    } else if (value == 1) {
      logout();
    }
  }

  logout() {
    Auth.logout();
    Navigator.of(context).pushReplacement(
      SlideLeftRoute(widget: Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Classes",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            offset: Offset(20, 20),
            icon: Icon(Icons.menu, color: AppColors.white),
            onSelected: choiceAction,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Create class"),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text("Log out"),
                  value: 1,
                ),
              ];
            },
          )
        ],
      ),
      body: Container(
          color: AppColors.background,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(Auth.uid)],
              ),
            ),
          )),
    );
  }
}
