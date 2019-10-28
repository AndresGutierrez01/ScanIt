import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanit/pages/Test.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/FirestoreStreams.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';
import 'package:scanit/widgets/AddStudentForm.dart';
import 'package:scanit/widgets/CenterLoad.dart';
import 'package:scanit/widgets/CreateTestForm.dart';
import 'package:scanit/widgets/EditStudentForm.dart';
import 'package:scanit/widgets/EditTestForm.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:scanit/widgets/StudentTile.dart';
import 'package:scanit/widgets/TestTile.dart';

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
  final TextEditingController testName = TextEditingController(text: "");

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

  createTestDialog() {
    clearControllers();
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CreateTestForm(
          nameCtr: testName,
          onCreate: createTest,
        );
      },
    );
  }

  editTestDialog(String id, Map data) {
    testName.text = data['name'];
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return EditTestForm(
          nameCtr: testName,
          onEdit: () => editTest(id),
        );
      },
    );
  }

  editTest(String id) {
    FirestoreTasks.editTest(widget.id, id, testName.text);
    Navigator.of(context).pop();
  }

  deleteTest(String id) {
    FirestoreTasks.deleteTest(widget.id, id);
  }

  createTest() {
    FirestoreTasks.createTest(widget.id, testName.text);
    Navigator.of(context).pop();
  }

  viewTest(String testId, String testName) {
    Navigator.of(context).push(
      SlideRightRoute(
          widget: Test(
        name: testName,
        testId: testId,
        classId: widget.id,
      )),
    );
  }

  clearControllers() {
    studentName.clear();
    studentId.clear();
    studentEmail.clear();
    testName.clear();
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
              padding: EdgeInsets.only(top: 30, bottom: 30),
              color: AppColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirestoreStreams.testsStream(widget.id),
                      builder: (context, tests) {
                        if (tests.hasData) {
                          List testDocs = tests.data.documents;
                          if (testDocs.isEmpty) {
                            return Center(
                              child: Text("No Tests",
                                  style: TextStyle(color: AppColors.gray)),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: testDocs.length,
                              itemBuilder: (context, index) {
                                return TestTile(
                                  testData: testDocs[index].data,
                                  testId: testDocs[index].documentID,
                                  onDelete: deleteTest,
                                  onEdit: editTestDialog,
                                  onTap: viewTest,
                                );
                              },
                            ),
                          );
                        }
                        return CenterLoad();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  FormButton(
                    text: ("Create Test"),
                    onTap: createTestDialog,
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
                  Padding(
                    padding: EdgeInsets.all(5),
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
