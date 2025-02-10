import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/3_third_exam.dart';
import 'exam_screen.dart';

class ThirdExam extends StatelessWidget {
  const ThirdExam(
      {super.key, required this.userAnswers, required this.examLength});
  final Map<String, dynamic> userAnswers;
  final double examLength;
  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 4,
      hasTime: false,
      userAnswers: userAnswers,
      appBarTitle: AppString.exam3Title,
      collectionName: AppString.thirdExamCollection,
      examLength: thirdExamQuestions.length,
      examQuestions: thirdExamQuestions.sublist(
          0,
          examLength < 50
              ? thirdExamQuestions.length
              : examLength < 75
                  ? ((thirdExamQuestions.length * 2) / 3).round()
                  : (thirdExamQuestions.length / 3).round()),
      // rightAnswers: thirdExamAnswers,
      showQuestionButton: false,
      // endTime: DateTime.now().add(
      //   const Duration(
      //     hours: 1,
      //     minutes: 0,
      //     seconds: 0,
      //   ),
      // ),
    );
  }
}
