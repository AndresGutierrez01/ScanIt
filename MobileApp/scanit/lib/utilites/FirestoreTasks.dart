import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreTasks {
  static void createUser(String uid) {
    Firestore.instance.collection('users').document(uid).setData({});
  }
}
