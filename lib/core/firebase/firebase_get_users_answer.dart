import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant/app_string.dart';

Future<List<Map<String, dynamic>>> getUsersAnswer() async {
  List<Map<String, dynamic>> usersAnswer = [];
  String userName;
  int preExamScore,
      firstExamScore,
      secondExamScore,
      thirdExamScore,
      fourthExamScore,
      fifthExamScore,
      postExamScore;

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  // print(querySnapshot.docs);
  for (var doc in querySnapshot.docs) {
    userName = doc["name"];
    String docId = doc.id;
    QuerySnapshot preExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.preExamCollection)
        .get();
    QuerySnapshot firstExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.firstExamCollection)
        .get();
    QuerySnapshot secondExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.secondExamCollection)
        .get();
    QuerySnapshot thirdExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.thirdExamCollection)
        .get();
    QuerySnapshot fourthExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.fourthExamCollection)
        .get();
    QuerySnapshot fifthExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.fifthExamCollection)
        .get();
    QuerySnapshot postExam = await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection(AppString.postExamCollection)
        .get();

    preExamScore = preExam.docs.isNotEmpty ? preExam.docs.first["score"] : 0;
    firstExamScore =
        firstExam.docs.isNotEmpty ? firstExam.docs.first["totalScore"] : 0;
    secondExamScore =
        secondExam.docs.isNotEmpty ? secondExam.docs.first["totalScore"] : 0;
    thirdExamScore =
        thirdExam.docs.isNotEmpty ? thirdExam.docs.first["totalScore"] : 0;
    fourthExamScore =
        fourthExam.docs.isNotEmpty ? fourthExam.docs.first["totalScore"] : 0;
    fifthExamScore =
        fifthExam.docs.isNotEmpty ? fifthExam.docs.first["totalScore"] : 0;
    postExamScore = postExam.docs.isNotEmpty ? postExam.docs.first["score"] : 0;
    (preExam.docs.isEmpty &&
                firstExam.docs.isEmpty &&
                secondExam.docs.isEmpty &&
                thirdExam.docs.isEmpty &&
                fourthExam.docs.isEmpty &&
                fifthExam.docs.isEmpty &&
                postExam.docs.isEmpty) ==
            false
        ? usersAnswer.add(
            {
              "userName": userName,
              "preExamScore": preExam.docs.isNotEmpty
                  ? preExam.docs.first["isFinished"]
                      ? preExam.docs.first["score"]
                      : -1
                  : -1,
              "firstExamScore": firstExam.docs.isNotEmpty
                  ? firstExam.docs.first["isFinished"]
                      ? firstExam.docs.first["totalScore"]
                      : -1
                  : -1,
              "secondExamScore": secondExam.docs.isNotEmpty
                  ? secondExam.docs.first["isFinished"]
                      ? secondExam.docs.first["totalScore"]
                      : -1
                  : -1,
              "thirdExamScore": thirdExam.docs.isNotEmpty
                  ? thirdExam.docs.first["isFinished"]
                      ? thirdExam.docs.first["totalScore"]
                      : -1
                  : -1,
              "fourthExamScore": fourthExam.docs.isNotEmpty
                  ? fourthExam.docs.first["isFinished"]
                      ? fourthExam.docs.first["totalScore"]
                      : -1
                  : -1,
              "fifthExamScore": fifthExam.docs.isNotEmpty
                  ? fifthExam.docs.first["isFinished"]
                      ? fifthExam.docs.first["totalScore"]
                      : -1
                  : -1,
              "postExamScore": postExam.docs.isNotEmpty
                  ? preExam.docs.first["isFinished"]
                      ? postExam.docs.first["score"]
                      : -1
                  : -1,
              "totalScore": preExamScore +
                  firstExamScore +
                  secondExamScore +
                  thirdExamScore +
                  fourthExamScore +
                  fifthExamScore +
                  postExamScore,
              // "isStart": preExam.docs.isEmpty &&
              //     firstExam.docs.isEmpty &&
              //     secondExam.docs.isEmpty &&
              //     thirdExam.docs.isEmpty &&
              //     fourthExam.docs.isEmpty &&
              //     fifthExam.docs.isEmpty &&
              //     postExam.docs.isEmpty,
            },
          )
        : null;
  }
  // print(usersAnswer);
  return usersAnswer;
}

//  ? {
//                 "name": userName,
//                 "answer": querySnapshot2.docs.first["answer"],
//                 "score": querySnapshot2.docs.first["score"],
//                 "startTime": querySnapshot2.docs.first["startTime"],
//                 "endTime": querySnapshot2.docs.first["endTime"],
//                 "isFinished": querySnapshot2.docs.first["isFinished"],
//               }
//             : {
//                 "name": userName,
//                 "totalScore": querySnapshot2.docs.first["totalScore"],
//                 "startTime": querySnapshot2.docs.first["startTime"],
//                 "endTime": querySnapshot2.docs.first["endTime"],
//                 "isFinished": querySnapshot2.docs.first["isFinished"],
//               },
