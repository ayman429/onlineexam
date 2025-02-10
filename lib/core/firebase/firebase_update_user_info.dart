import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_get_doc_id.dart';

Future<void> updateUserData({required int percent}) async {
  String docId = await getDocId();
  FirebaseFirestore.instance.collection('users').doc(docId).update({
    "percent": percent,
  });
}

Future<void> updateSessions({required List session}) async {
  String docId = await getDocId();
  FirebaseFirestore.instance.collection('users').doc(docId).update({
    "Sessions": session,
  });
}
