import 'package:flutter/material.dart';
import 'package:scanit/Database_Classes/teacher.dart';
import 'package:scanit/pages/Courses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseList extends StatefulWidget {
  final Teacher teacher;
  CourseList({@required this.teacher,});
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList>{
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.teacher.courseRef.getDocuments().asStream(),
        builder: (context, snapshot) {
            List<DocumentSnapshot> _courseList = snapshot.data.documents.toList();
            return ListView.builder(
              itemCount: _courseList.length,
              itemBuilder: (context, index) {
                Course curCourse; //= Course(_courseList[index]);
                return Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 36.5),
                      //child: Text(/*Add Stuff Here as well*/),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      /* Navigator.pushNamed(context, 'coursePage',
                          arguments: Course( /*ADD Stuff here*/)); */
                    },
                  ),
                );
              },
            );
        });
  }
}
