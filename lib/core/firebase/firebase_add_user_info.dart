import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addUserData() async {
  await FirebaseFirestore.instance.collection('users').add({
    "id": FirebaseAuth.instance.currentUser!.uid,
    "name": FirebaseAuth.instance.currentUser!.displayName,
    "percent": 0,
    "Sessions": []
  });
}
