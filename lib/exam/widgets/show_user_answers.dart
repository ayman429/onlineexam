import 'package:flutter/material.dart';
import 'package:onlineexam/core/constant/app_color.dart';
import 'package:onlineexam/core/exams/6_post_exam.dart';

import '../../core/constant/app_string.dart';
import '../../core/firebase/firebase_get_user_answer.dart';
import 'questions_ui.dart';

class ShowUserAnswers extends StatelessWidget {
  const ShowUserAnswers({
    super.key,
  });
  // final List<Map<String, dynamic>> examQuestions;
  // final List<int>? rightAnswers;
  // final List<int> userAnswers;
  // final String appBarTitle;
  // final String? collectionName;
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
          AppString.postExamTitle,
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
      body: FutureBuilder(
          future: getUserAnswer(
              collectionName: AppString.postExamCollection,
              docUserId: "",
              showQuestionButton: true),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // عرض مؤشر تحميل أثناء الانتظار
            } else if (snapshot.hasError) {
              return const SizedBox();
            } else {
              if (snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: snapshot.data!["answer"].length,
                    itemBuilder: (context, index) {
                      // return const Text("not  work");
                      return Column(
                        children: [
                          index == 0
                              ? Container(
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
                                  child: IntrinsicWidth(
                                    child: Row(
                                      children: [
                                        // const Text(
                                        //   "نقاطك",
                                        //   style: TextStyle(
                                        //       fontSize: 20,
                                        //       fontWeight: FontWeight.bold,
                                        //       color: AppColor.textColor3),
                                        // ),
                                        Container(
                                          // margin:
                                          //     const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFb1feb1), //AppColor.backgroundColor4,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'نتيجتك: ${snapshot.data!["userAnswersData"]["totalScore"]}',
                                            style: const TextStyle(
                                                color: AppColor.textColor3,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )

                              // Text(
                              //     'نتيجتك: ${snapshot.data!["userAnswersData"]["totalScore"]}',
                              //     style: const TextStyle(
                              //       fontSize: 26,
                              //       fontWeight: FontWeight.bold,
                              //       color: AppColor.primaryColor,
                              //     ),
                              //   )
                              : SizedBox(),
                          index == 0 ? SizedBox(height: 20) : SizedBox(),
                          QuestionsUi(
                            rightAnswer: postExamAnswers[index],
                            isShowAnswer: false,
                            showQuestionButton: true,
                            examQuestions: postExamQuestions[index],
                            index: index,
                            radioValue: snapshot.data!["answer"][index],
                            isAnswered: true,
                            onChanged: (value) {},
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "لم تقم بحل الامتحان بعد",
                    style: const TextStyle(
                        color: AppColor.textColor3,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
            }
          }),
    );
  }
}
