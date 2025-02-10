import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/0_pre_exam.dart';
import 'exam_screen.dart';

class PreExam extends StatelessWidget {
  const PreExam({super.key, required this.userAnswers});
  final Map<String, dynamic> userAnswers;
  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 1,
      hasTime: false,
      userAnswers: userAnswers,
      appBarTitle: AppString.preExamTitle,
      collectionName: AppString.preExamCollection,
      examQuestions: preExamQuestions,
      // rightAnswers: preExamAnswers,
      showQuestionButton: true,
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
