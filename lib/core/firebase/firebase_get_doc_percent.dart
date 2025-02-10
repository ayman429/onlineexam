import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<int> getDocPercent() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
  return querySnapshot.docs.first["percent"];
}
