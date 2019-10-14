import 'package:flutter/material.dart';
import 'package:scanit/pages/AddCourse.dart';
import 'package:scanit/widgets/AddCourseButton.dart';
import 'package:scanit/widgets/SlideRightRoute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Course extends StatefulWidget {
  final FirebaseUser teacher;
  Course(this.teacher);
  @override
  _CourseState createState() => _CourseState();
}



class _CourseState extends State<Course> {

  addCourse() {
    Navigator.of(context).pushReplacement(
      SlideRightRoute(widget: AddCourse()),
    );
  }


  @override
  Widget build(BuildContext context) {

    

    AddCourseButton(
      text: "Add a course",
      onTap: addCourse,
    );
    return null;
  }
  
}