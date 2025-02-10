import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getUsersSessions() async {
  List<Map<String, dynamic>> usersSessions = [];
  String userName;

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  // print(querySnapshot.docs);
  for (var doc in querySnapshot.docs) {
    userName = doc["name"];

    // print("${doc["Sessions"]}");
    // String docId = doc.id;
    List<Map<String, dynamic>> userSessions = [];

    userSessions = List<Map<String, dynamic>>.from(doc["Sessions"]);

    userSessions.isEmpty
        ? null
        : usersSessions.add({
            "name": userName,
            "userSessions": userSessions,
            "docId": doc.id,
            "userNamber": querySnapshot.docs.length,
          });
  }
  print("==================");
  print(usersSessions);
  return usersSessions;
}
