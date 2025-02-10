import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getDocId() async {
  try {
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    print("rrrrrrrrrr ${querySnapshot.docs.first.id}");
    return querySnapshot.docs.first.id;
  } catch (e) {
    print("xxxxxxxxx = $e");
    return Future.error(Exception(e));
  }
  // return querySnapshot.docs.first.id;
  // return Future.value("true"); //Future.error(Exception("Error"));
}
