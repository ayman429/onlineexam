import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getUsersAnswerPrePostExam({
  required String collectionName,
}) async {
  List<Map<String, dynamic>> usersAnswer = [];
  String userName;

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  // print(querySnapshot.docs);
  for (var doc in querySnapshot.docs) {
    userName = doc["name"];
    String docId = doc.id;
    QuerySnapshot prePostExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(collectionName)
        .get();
    prePostExam.docs.isNotEmpty
        ? prePostExam.docs.first["isFinished"]
            ? usersAnswer.add(
                {"name": userName, "answer": prePostExam.docs.first["answer"]})
            : null
        : null;
  }
  // print(usersAnswer);
  return usersAnswer;
}
