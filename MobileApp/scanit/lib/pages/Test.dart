import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanit/pages/EditKey.dart';
import 'package:scanit/utilites/AppColors.dart';
import 'package:scanit/utilites/FirestoreStreams.dart';
import 'package:scanit/utilites/FirestoreTasks.dart';
import 'package:scanit/widgets/CenterLoad.dart';
import 'package:scanit/widgets/PopUpLoadDialog.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:scanit/widgets/SubmittedAnswersDialog.dart';
import 'package:scanit/widgets/GradeTile.dart';
import 'package:scanit/widgets/FormButton.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:async/async.dart';

class Test extends StatefulWidget {
  final String testId;
  final String classId;
  final String name;

  Test({@required this.testId, @required this.classId, @required this.name});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  grade(context) async {
    File imageScan = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageScan == null) {
      return;
    }

    String url = "http://18.216.41.122:8080/grade";
    String testKey =
        await FirestoreTasks.getTestKey(widget.classId, widget.testId);

    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopUpLoadDialog();
      },
    );

    Map formData = {
      'submission': imageScan,
      'key': testKey,
      'id-len': 8,
      'num-questions': testKey.length
    };

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageScan.openRead()));
    var length = await imageScan.length();
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.fields['id-len'] = '10';
    request.fields['key'] = '01923919837491240193';
    var multipartFile = new http.MultipartFile('submission', stream, length,
        filename: basename(imageScan.path));
    request.files.add(multipartFile);
    request.send().then((response) async {
      print(await response.stream.bytesToString());
      Navigator.of(context).pop();
    });
  }

  editKey(context) async {
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

  showSubmission(submission, context) {
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
            onPressed: () {
              editKey(context);
            },
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
                                  showSubmission(
                                      grades[index]['submitted'], context);
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
                onTap: () {
                  grade(context);
                },
              ),
            ],
          )),
    );
  }
}
