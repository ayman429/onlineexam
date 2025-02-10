import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/5_fifth_exam.dart';
import 'exam_screen.dart';

class FifthExam extends StatelessWidget {
  const FifthExam(
      {super.key, required this.userAnswers, required this.examLength});
  final Map<String, dynamic> userAnswers;
  final double examLength;
  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 6,
      hasTime: false,
      userAnswers: userAnswers,
      appBarTitle: AppString.exam5Title,
      collectionName: AppString.fifthExamCollection,
      examLength: fifthExamQuestions.length,
      examQuestions: fifthExamQuestions,
      // rightAnswers: fifthExamAnswers,
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
