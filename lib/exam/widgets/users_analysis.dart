import 'package:flutter/material.dart';
import 'package:onlineexam/core/exams/0_pre_exam.dart';
import 'package:onlineexam/generated/l10n.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_string.dart';
import '../../core/exams/6_post_exam.dart';
import '../../core/firebase/firebase_get_doc_sessions.dart';
import '../../core/firebase/firebase_get_user_answer.dart';
import '../../core/firebase/firebase_get_users_sessions.dart';
import '../functions/calculate_user_answer.dart';
import '../functions/loading_dialog.dart';
import 'User_analysis.dart';
import 'chart1.dart';
import 'chart3.dart';
import 'chart4.dart';
import 'custom_text_container.dart';
import 'leader_board.dart';

class UsersAnalysis extends StatefulWidget {
  const UsersAnalysis({super.key});

  @override
  State<UsersAnalysis> createState() => _UsersAnalysisState();
}

class _UsersAnalysisState extends State<UsersAnalysis> {
  List<Map<String, dynamic>> docSessions = [];
  Map<int, dynamic> userAnswersCountPreExam = {};
  Map<int, dynamic> userAnswersCountPostExam = {};
  bool isLoading = true;
  // Map<String, dynamic> userAnswersPreExamAnalysis = {};
  // Map<String, dynamic> userAnswersPostExamAnalysis = {};
  usersAnalysis() async {
    docSessions = await getUsersSessions();
    userAnswersCountPreExam =
        await calculateUserAnswer(collectionName: AppString.preExamCollection);
    userAnswersCountPostExam =
        await calculateUserAnswer(collectionName: AppString.postExamCollection);
    isLoading = false;

    // print("xxxxxxxxxxxxxxxxxxxxxxxxx");
    // print(userAnswersPreExamAnalysis["userAnswersData"]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      usersAnalysis();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor3,
        surfaceTintColor: AppColor.backgroundColor3,
        shadowColor: const Color(0xFFc9d3de),
        elevation: 4,
        title: const Text(
          "تحليلات",
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.textColor3,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : UsersSessionsTables(
              docSessions: docSessions,
              userAnswersCountPostExam: userAnswersCountPostExam,
              userAnswersCountPreExam: userAnswersCountPreExam,
            ),
    );
  }
}

class UsersSessionsTables extends StatelessWidget {
  const UsersSessionsTables({
    super.key,
    required this.docSessions,
    required this.userAnswersCountPreExam,
    required this.userAnswersCountPostExam,
  });

  final List<Map<String, dynamic>> docSessions;
  final Map<int, dynamic> userAnswersCountPreExam;
  final Map<int, dynamic> userAnswersCountPostExam;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            docSessions.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userAnswersCountPreExam.isNotEmpty
                          ? BarCharPrePostExam(
                              userNamber: docSessions[0]["userNamber"],
                              title: AppString.preExamTitle,
                              userAnswersCountPrePostExam:
                                  userAnswersCountPreExam,
                              rightAnswers: preExamAnswers)
                          : const SizedBox(),
                      userAnswersCountPostExam.isNotEmpty
                          ? BarCharPrePostExam(
                              userNamber: docSessions[0]["userNamber"],
                              title: AppString.postExamTitle,
                              userAnswersCountPrePostExam:
                                  userAnswersCountPostExam,
                              rightAnswers: postExamAnswers)
                          : const SizedBox(),
                    ],
                  )
                : const SizedBox(),

            // const SizedBox(height: 20),
            docSessions.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                          "تحليل الجلسات",
                          style: const TextStyle(
                              color: AppColor.textColor3,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        for (int i = 0; i < docSessions.length; i++) ...[
                          GestureDetector(
                            onTap: () async {
                              // ------------------
                              Map<String, dynamic> userAnswersPreExamAnalysis =
                                  {};
                              Map<String, dynamic> userAnswersPostExamAnalysis =
                                  {};
                              loadingDialog(context);
                              userAnswersPreExamAnalysis = await getUserAnswer(
                                  docUserId: docSessions[i]["docId"],
                                  collectionName: AppString.preExamCollection,
                                  showQuestionButton: true);
                              // ---------------------
                              userAnswersPostExamAnalysis = await getUserAnswer(
                                  docUserId: docSessions[i]["docId"],
                                  collectionName: AppString.postExamCollection,
                                  showQuestionButton: true);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return UserAnalysis(
                                    docUserId: docSessions[i]["docId"],
                                    userAnswersPreExamAnalysis:
                                        userAnswersPreExamAnalysis[
                                                "userAnswersData"] ??
                                            {},
                                    userAnswersPostExamAnalysis:
                                        userAnswersPostExamAnalysis[
                                                "userAnswersData"] ??
                                            {},
                                  );
                                },
                              ));
                            },
                            child: UserSessionsWidget(
                              userSessions: docSessions[i]['userSessions'],
                              docSessions: docSessions,
                              index: i,
                            ),
                          ),
                        ]
                      ])
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height / 2 - 120),
                      child: Text(
                        "لا يوجد جلسات بعد",
                        style: TextStyle(
                            color: AppColor.textColor3,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class BarCharPrePostExam extends StatelessWidget {
  const BarCharPrePostExam({
    super.key,
    required this.userAnswersCountPrePostExam,
    required this.title,
    required this.rightAnswers,
    required this.userNamber,
  });

  final Map<int, dynamic> userAnswersCountPrePostExam;
  final String title;
  final List<int> rightAnswers;
  final int userNamber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColor.textColor3,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.only(right: 10, top: 30, bottom: 10),
            margin: const EdgeInsets.only(left: 10, bottom: 20),
            decoration: BoxDecoration(
              color: AppColor.backgroundColor4,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFc9d3de),
                  blurRadius: 6,
                  spreadRadius: 4,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                for (int i = 0;
                    i < userAnswersCountPrePostExam.length;
                    i++) ...[
                  Column(
                    children: [
                      BarChartSample7(
                          userNamber: userNamber,
                          rightAnswers: rightAnswers[i],
                          showYaxis: i == 0 ? true : false,
                          userAnswersCountPrePostExam:
                              userAnswersCountPrePostExam[i]),
                      Text("Q${i + 1}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class UserSessionsWidget extends StatelessWidget {
  const UserSessionsWidget(
      {super.key,
      required this.userSessions,
      required this.docSessions,
      required this.index});
  final List<Map<String, dynamic>> userSessions;
  final List<Map<String, dynamic>> docSessions;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor4,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFc9d3de),
            blurRadius: 6,
            spreadRadius: 4,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            docSessions[index]['name'],
            style: const TextStyle(
                color: AppColor.textColor3,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          CustomTextContainer(
            title: "الزمن الكلي",
            value: getTotalTime(userSessions).toString().split('.000000')[0],
          ),
          const DividerWidget(),
          for (int i = 0; i < userSessions.length; i++) ...[
            CustomTextContainer(
              title: "زمن الجلسة ${i + 1}",
              value: Duration(
                      seconds: (int.parse(userSessions[i]['exitTime']) -
                          int.parse(userSessions[i]['enterTime'])))
                  .toString()
                  .split('.000000')[0],
            ),
            const DividerWidget(),
            CustomTextContainer(
              title: "عدد الاختبارات التي تم حلها",
              value: (userSessions[i]['endPrecent'] -
                      userSessions[i]['startPrecent'])
                  .toString(),
            ),
            i == userSessions.length - 1
                ? const SizedBox()
                : const DividerWidget()
          ]
        ],
      ),
    );
  }

  Duration getTotalTime(userSessions) {
    Duration totalTime = Duration.zero;
    for (int i = 0; i < userSessions.length; i++) {
      totalTime = totalTime +
          Duration(
              seconds: (int.parse(userSessions[i]['exitTime']) -
                  int.parse(userSessions[i]['enterTime'])));
    }
    // print("=================");
    // print(totalTime);
    return totalTime;
  }
}

// SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   DataTable(columns: const <DataColumn>[
//                     DataColumn(
//                       label: Text(
//                         "الجلسة 1",
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "الجلسة 2",
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "الجلسة 3",
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "4",
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "5",
//                       ),
//                     ),
//                   ], rows: const <DataRow>[
//                     DataRow(cells: <DataCell>[
//                       DataCell(Text("1")),
//                       DataCell(Text("2")),
//                       DataCell(Text("3")),
//                       DataCell(Text("4")),
//                       DataCell(Text("5"))
//                     ]),
//                   ]),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
