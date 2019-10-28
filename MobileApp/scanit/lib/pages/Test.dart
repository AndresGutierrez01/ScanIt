import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scanit/pages/EditKey.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/FirestoreStreams.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:scanit/widgets/SubmittedAnswersDialog.dart';
import 'package:scanit/widgets/GradeTile.dart';
import 'package:scanit/widgets/FormButton.dart';

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

    showSubmission(submission) {
      showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SubmittedAnswersDialog(submission: submission.split(''));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
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
      body: Container(
          alignment: Alignment(0, 0),
          color: AppColors.background,
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirestoreStreams.gradesStream(
                          widget.classId, widget.testId),
                      builder: (context, gradesSnapshot) {
                        List<DocumentSnapshot> grades =
                            gradesSnapshot.data.documents;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: grades.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showSubmission(grades[index]['submitted']);
                              },
                              child: GradeTile(
                                grade: grades[index],
                              ),
                            );
                          },
                        );
                      })),
              FormButton(
                text: ("Grade Test"),
                onTap: () {},
              ),
            ],
          )),
    );
  }
}
