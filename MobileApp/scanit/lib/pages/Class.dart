import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/FirestoreStreams.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';
import 'package:scanit/widgets/AddStudentForm.dart';
import 'package:scanit/widgets/CenterLoad.dart';
import 'package:scanit/widgets/EditStudentForm.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/StudentTile.dart';

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
  final TextEditingController studentName = TextEditingController(text: "");
  final TextEditingController studentId = TextEditingController(text: "");
  final TextEditingController studentEmail = TextEditingController(text: "");

  addStudentDialog() {
    clearControllers();
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AddStudentForm(
          nameCtr: studentName,
          idCtr: studentId,
          emailCtr: studentEmail,
          onAdd: addStudent,
        );
      },
    );
  }

  addStudent() {
    FirestoreTasks.addStudent(
        widget.id, studentName.text, studentEmail.text, studentId.text);
    Navigator.of(context).pop();
    clearControllers();
  }

  editStudentDialog(String id, Map data) {
    studentName.text = data['name'];
    studentEmail.text = data['email'];
    studentId.text = data['id'];

    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return EditStudentForm(
          nameCtr: studentName,
          idCtr: studentId,
          emailCtr: studentEmail,
          onAdd: () => editStudent(id),
        );
      },
    );
  }

  editStudent(String id) {
    FirestoreTasks.editStudent(
        widget.id, id, studentName.text, studentEmail.text, studentId.text);
    Navigator.of(context).pop();
  }

  deleteStudent(String id) {
    FirestoreTasks.deleteStudent(widget.id, id);
  }

  clearControllers() {
    studentName.clear();
    studentId.clear();
    studentEmail.clear();
  }

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
              Tab(
                text: "Students",
              )
            ],
          ),
          title: Text(
            widget.title,
            style: TextStyle(color: AppColors.aqua),
          ),
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
                    onTap: () => {},
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              color: AppColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirestoreStreams.studentsStream(widget.id),
                      builder: (context, students) {
                        if (students.hasData) {
                          List studentDocs = students.data.documents;
                          if (studentDocs.isEmpty) {
                            return Center(
                              child: Text("No Students",
                                  style: TextStyle(color: AppColors.gray)),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: studentDocs.length,
                              itemBuilder: (context, index) {
                                return StudentTile(
                                  studentData: studentDocs[index].data,
                                  studentId: studentDocs[index].documentID,
                                  onDelete: deleteStudent,
                                  onEdit: editStudentDialog,
                                );
                              },
                            ),
                          );
                        }
                        return CenterLoad();
                      },
                    ),
                  ),
                  FormButton(
                    text: ("Add Student"),
                    onTap: addStudentDialog,
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
