import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/1_first_exam.dart';
import 'exam_screen.dart';

class FirstExam extends StatelessWidget {
  const FirstExam(
      {super.key, required this.userAnswers, required this.examLength});
  final Map<String, dynamic> userAnswers;
  final double examLength;

  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 2,
      hasTime: false,
      userAnswers: userAnswers,
      appBarTitle: AppString.exam1Title,
      collectionName: AppString.firstExamCollection,
      examLength: firstExamQuestions.length,
      examQuestions: firstExamQuestions.sublist(
          0,
          examLength < 50
              ? firstExamQuestions.length
              : examLength < 75
                  ? ((firstExamQuestions.length * 2) / 3).round()
                  : (firstExamQuestions.length / 3).round()),
      // rightAnswers: firstExamAnswers,
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
