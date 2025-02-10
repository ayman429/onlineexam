import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/2_second_exam.dart';
import 'exam_screen.dart';

class SecondExam extends StatelessWidget {
  const SecondExam(
      {super.key, required this.userAnswers, required this.examLength});
  final Map<String, dynamic> userAnswers;
  final double examLength;
  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 3,
      hasTime: false,
      userAnswers: userAnswers,
      appBarTitle: AppString.exam2Title,
      collectionName: AppString.secondExamCollection,
      examLength: secondExamQuestions.length,
      examQuestions: secondExamQuestions.sublist(
          0,
          examLength < 50
              ? secondExamQuestions.length
              : examLength < 75
                  ? ((secondExamQuestions.length * 2) / 3).round()
                  : (secondExamQuestions.length / 3).round()),
      // rightAnswers: secondExamAnswers,
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
