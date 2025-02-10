import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_get_doc_id.dart';

Future<void> updateExamData(
    {required String collectionName,
    required String subDocId,
    required Map<String, dynamic> data}) async {
  try {
    String docId = await getDocId();
    FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(collectionName)
        .doc(subDocId)
        .update(data);
  } catch (e) {
    print("Error in updateExamData: $e");
  }
}
