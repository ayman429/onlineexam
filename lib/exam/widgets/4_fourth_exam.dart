import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/4_fourth_exam.dart';
import 'exam_screen.dart';

class FourthExam extends StatelessWidget {
  const FourthExam(
      {super.key, required this.userAnswers, required this.examLength});
  final Map<String, dynamic> userAnswers;
  final double examLength;
  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 5,
      hasTime: false,
      userAnswers: userAnswers,
      appBarTitle: AppString.exam4Title,
      collectionName: AppString.fourthExamCollection,
      examLength: fourthExamQuestions.length,
      examQuestions: fourthExamQuestions.sublist(
          0,
          examLength < 50
              ? fourthExamQuestions.length
              : examLength < 75
                  ? ((fourthExamQuestions.length * 2) / 3).round()
                  : (fourthExamQuestions.length / 3).round()),
      // rightAnswers: fourthExamAnswers,
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
