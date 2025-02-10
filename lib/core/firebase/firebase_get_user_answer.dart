import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_get_doc_id.dart';

Future<Map<String, dynamic>> getUserAnswer(
    {required String collectionName,
    required bool showQuestionButton,
    required String docUserId}) async {
  String docId = await getDocId();
  Map<String, dynamic> userAnswer = {};
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(docUserId == "" ? docId : docUserId)
      .collection(collectionName)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    userAnswer = showQuestionButton
        ? querySnapshot.docs.first["isFinished"]
            ? {
                "answer": querySnapshot.docs.first["answer"],
                "score": querySnapshot.docs.first["score"],
                "userAnswersData": querySnapshot.docs.first["userAnswersData"],
                "id": querySnapshot.docs.first.id,
                // "questionNumberState":
                //     querySnapshot.docs.first["questionNumberState"] ?? [],
                "startTime": querySnapshot.docs.first["startTime"],
                "endTime": querySnapshot.docs.first["endTime"],
                "isFinished": querySnapshot.docs.first["isFinished"],
              }
            : {
                "answer": querySnapshot.docs.first["answer"],
                "score": querySnapshot.docs.first["score"],
                "id": querySnapshot.docs.first.id,
                "questionNumberState":
                    querySnapshot.docs.first["questionNumberState"],
                "startTime": querySnapshot.docs.first["startTime"],
                "endTime": querySnapshot.docs.first["endTime"],
                "isFinished": querySnapshot.docs.first["isFinished"],
              }
        : querySnapshot.docs.first["isFinished"]
            ? {
                "totalScore": querySnapshot.docs.first["totalScore"],
                "id": querySnapshot.docs.first.id,
                "startTime": querySnapshot.docs.first["startTime"],
                "endTime": querySnapshot.docs.first["endTime"],
                "isFinished": querySnapshot.docs.first["isFinished"],
                "levelDetails": querySnapshot.docs.first["levelDetails"],
              }
            : {
                "index": querySnapshot.docs.first["index"],
                "isShowAnswer": querySnapshot.docs.first["isShowAnswer"],
                "radioValueI": querySnapshot.docs.first["radioValueI"],
                //
                "item": querySnapshot.docs.first["item"],
                "level": querySnapshot.docs.first["level"],
                "questionNumber": querySnapshot.docs.first["questionNumber"],
                "levelQNumber": querySnapshot.docs.first["levelQNumber"],
                "userAnser": querySnapshot.docs.first["userAnser"],
                "easy": querySnapshot.docs.first["easy"],
                "medium": querySnapshot.docs.first["medium"],
                "hard": querySnapshot.docs.first["medium"],
                "itemCount": querySnapshot.docs.first["itemCount"],
                "itemScore": querySnapshot.docs.first["itemScore"],

                "totalScore": querySnapshot.docs.first["totalScore"],
                "id": querySnapshot.docs.first.id,
                "startTime": querySnapshot.docs.first["startTime"],
                "endTime": querySnapshot.docs.first["endTime"],
                "isFinished": querySnapshot.docs.first["isFinished"],
                "levelDetails": querySnapshot.docs.first["levelDetails"],
              };
  }

  return userAnswer;
}
