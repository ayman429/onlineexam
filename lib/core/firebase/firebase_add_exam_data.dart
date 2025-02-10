import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_get_doc_id.dart';

void addExamData(
    {required String collectionName,
    required Map<String, dynamic> data}) async {
  String docId = await getDocId();
  FirebaseFirestore.instance
      .collection('users')
      .doc(docId)
      .collection(collectionName)
      .add(data);
}
