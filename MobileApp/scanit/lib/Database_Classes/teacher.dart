import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teacher {
  DocumentReference userRef;
  String email;
  String fname;
  String lname;
  
  String uid;
  String courseName;

  ///Reference to the collection of Courses pertaining to a single person.
  CollectionReference courseRef;

  Teacher(DocumentSnapshot user) {
    userRef = user.reference;
    courseRef = userRef.collection("Courses");
    email = user.data["email"];
    fname = user.data["fname"];
    lname = user.data["lname"];

    uid = user.documentID;
  }

}
