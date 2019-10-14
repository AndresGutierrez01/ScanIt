import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanit/utilites/Auth.dart';

class FirestoreStreams {
  static Stream<QuerySnapshot> classesStream() {
    return Firestore.instance
        .collection('users')
        .document(Auth.uid)
        .collection('classes')
        .snapshots();
  }
}
