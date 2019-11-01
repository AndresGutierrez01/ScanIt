import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanit/pages/EditKey.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/FirestoreStreams.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';
import 'package:scanit/widgets/CenterLoad.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:scanit/widgets/SubmittedAnswersDialog.dart';
import 'package:scanit/widgets/GradeTile.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  final String testId;
  final String classId;
  final String name;

  Test({@required this.testId, @required this.classId, @required this.name});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  grade() async{
    File imageScan = await ImagePicker.pickImage(source: ImageSource.camera);
    if(imageScan == null){
      return;
    }

    String api = "http://18.216.41.122:8080/grade";
    String testKey =
        await FirestoreTasks.getTestKey(widget.classId, widget.testId);

    Map formData = {
      'submission': imageScan,
      'key': testKey,
      'id-len': 8,
      'num-questions': testKey.length
    };

    var client = new http.Client();
    http.Response r = await client.post(api);
    print(r.body);
    
    
  }

  editKey() async {
    String testKey =
        await FirestoreTasks.getTestKey(widget.classId, widget.testId);
    Navigator.of(context).push(
      SlideRightRoute(
          widget: EditKey(
        classId: widget.classId,
        testId: widget.testId,
        testKey: testKey,
      )),
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

  @override
  Widget build(BuildContext context) {
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
                        if (gradesSnapshot.hasData) {
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
                        }
                        return CenterLoad();
                      })),
              FormButton(
                text: ("Grade Test"),
                onTap: grade,
              ),
            ],
          )),
    );
  }
}
