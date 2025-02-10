import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:onlineexam/core/exams/0_pre_exam.dart';
import 'package:onlineexam/core/exams/2_second_exam.dart';
import 'package:onlineexam/core/exams/3_third_exam.dart';
import 'package:onlineexam/core/exams/5_fifth_exam.dart';
import 'package:onlineexam/core/exams/6_post_exam.dart';

import '../../core/constant/app_color.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/1_first_exam.dart';
import '../../core/exams/4_fourth_exam.dart';
import '../../core/firebase/firebase_get_users_answer.dart';

class ShowUsersAnswers extends StatelessWidget {
  const ShowUsersAnswers({
    super.key,
  });

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
          "قائمة المتصدرين",
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
      body: const Leaderboard(),
    );
  }
}

class Leaderboard extends StatelessWidget {
  const Leaderboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 250,
              child: Lottie.asset('assets/animations/animation2.json')),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: getUsersAnswer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // عرض مؤشر تحميل أثناء الانتظار
                } else if (snapshot.hasError) {
                  return const SizedBox();
                } else {
                  if (snapshot.data!.isNotEmpty) {
                    snapshot.data!.sort(
                        (a, b) => b['totalScore'].compareTo(a['totalScore']));
                    int index = 0, score = -1;
                    return Column(
                      children: snapshot.data!.asMap().entries.map((entry) {
                        final e = entry.value;
                        if (score == e["totalScore"]) {
                        } else {
                          score != -1 ? index++ : null;
                        }
                        score = e["totalScore"];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
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
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e['userName'],
                                  style: const TextStyle(
                                      color: AppColor.textColor3,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                // const DividerWidget(),

                                Row(
                                  children: [
                                    MediaQuery.sizeOf(context).width < 285
                                        ? Column(
                                            children: [
                                              const Text(
                                                "مجموع النقاط",
                                                style: TextStyle(
                                                    color: AppColor.textColor1,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xFFb1feb1), //AppColor.backgroundColor4,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "${e['totalScore']}",
                                                  style: const TextStyle(
                                                      color:
                                                          AppColor.textColor3,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              const Text(
                                                "مجموع النقاط",
                                                style: TextStyle(
                                                    color: AppColor.textColor1,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xFFb1feb1), //AppColor.backgroundColor4,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "${e['totalScore']}",
                                                  style: const TextStyle(
                                                      color:
                                                          AppColor.textColor3,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                    const Spacer(),
                                    index == 0
                                        ? SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Lottie.asset(
                                              'assets/animations/animation3.json',
                                            ),
                                          )
                                        : const SizedBox(),
                                    index == 1
                                        ? SizedBox(
                                            height: 100,
                                            child: Lottie.asset(
                                              'assets/animations/animation4.json',
                                            ),
                                          )
                                        : const SizedBox(),
                                    index == 2
                                        ? SizedBox(
                                            height: 100,
                                            child: Lottie.asset(
                                              'assets/animations/animation5.json',
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),

                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.preExamTitle,
                                  examScore: 'preExamScore',
                                  e: e,
                                  finalGrade: preExamQuestions.length * 20,
                                ),
                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.exam1Title,
                                  examScore: 'firstExamScore',
                                  e: e,
                                  finalGrade: firstExamQuestions.length * 20,
                                ),
                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.exam2Title,
                                  examScore: 'secondExamScore',
                                  e: e,
                                  finalGrade: secondExamQuestions.length * 20,
                                ),
                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.exam3Title,
                                  examScore: 'thirdExamScore',
                                  e: e,
                                  finalGrade: thirdExamQuestions.length * 20,
                                ),
                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.exam4Title,
                                  examScore: 'fourthExamScore',
                                  e: e,
                                  finalGrade: fourthExamQuestions.length * 20,
                                ),
                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.exam5Title,
                                  examScore: 'fifthExamScore',
                                  e: e,
                                  finalGrade: fifthExamQuestions.length * 20,
                                ),
                                const DividerWidget(),
                                ExamScoreItem(
                                  examTitle: AppString.postExamTitle,
                                  examScore: 'postExamScore',
                                  e: e,
                                  finalGrade: postExamQuestions.length * 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );

                    // return ListView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: snapshot.data!.length,
                    //   itemBuilder: (context, index) {

                    //   },
                    // );
                  } else {
                    return SizedBox(width: MediaQuery.of(context).size.width);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Divider(
        thickness: 0.3,
        color: Colors.grey, //AppColor.backgroundColor2,
      ),
    );
  }
}

class ExamScoreItem extends StatelessWidget {
  const ExamScoreItem({
    super.key,
    required this.examTitle,
    required this.e,
    required this.examScore,
    required this.finalGrade,
  });
  final String examTitle;

  final String examScore;
  final Map<String, dynamic> e;
  final int finalGrade;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            examTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: AppColor.textColor1,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(
                //horizontal: e[examScore] == -1 ? 10 : 16,
                vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.backgroundColor4, //AppColor.backgroundColor4,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey, //Color(0xFFb1feb1),
                  blurRadius: 3, // مقدار التمويه
                  spreadRadius: 0.2, // مدى انتشار الظل
                  // offset: Offset(
                  //     2, 4), // تحريك الظل (X, Y)
                ),
              ],
            ),
            child: Center(
              child: Text(
                e[examScore] == -1
                    ? "لم يتم الحل"
                    : "${e[examScore]}/$finalGrade",
                style: TextStyle(
                    color: e[examScore] == -1
                        ? AppColor.textColor3
                        : AppColor.iconColor3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
