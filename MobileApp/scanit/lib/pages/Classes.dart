import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanit/pages/Login.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/Auth.dart';
import 'package:scanit/utilites/FirestoreStreams.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';
import 'package:scanit/widgets/CenterLoad.dart';
import 'package:scanit/widgets/ClassTile.dart';
import 'package:scanit/widgets/CreateClassForm.dart';
import 'package:scanit/widgets/SlideLeftRoute.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  final TextEditingController className = TextEditingController(text: "");
  final TextEditingController classNumber = TextEditingController(text: "");
  final TextEditingController classSection = TextEditingController(text: "");

  choiceAction(value) {
    if (value == 0) {
      createClassDialog();
    } else if (value == 1) {
      logout();
    }
  }

  createClassDialog() {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CreateClassForm(
          nameCtr: className,
          numberCtr: classNumber,
          sectionCtr: classSection,
          onCreate: createClass,
        );
      },
    );
  }

  createClass() {
    FirestoreTasks.createClass(
        className.text, classNumber.text, classSection.text);
    Navigator.of(context).pop();
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
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreStreams.classesStream(),
          builder: (context, classes) {
            if (classes.hasData) {
              List classDocs = classes.data.documents;
              if (classDocs.isEmpty) {
                return Center(
                  child: Text("No Classes",
                      style: TextStyle(color: AppColors.gray)),
                );
              }
              return ListView.builder(
                itemCount: classDocs.length,
                itemBuilder: (context, index) {
                  return ClassTile(
                    classData: classDocs[index].data,
                    classId: 'asdfsd',
                  );
                },
              );
            }
            return CenterLoad();
          },
        ),
      ),
    );
  }
}
