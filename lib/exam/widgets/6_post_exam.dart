import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import '../../core/exams/6_post_exam.dart';
import 'exam_screen.dart';

class PostExam extends StatelessWidget {
  const PostExam({super.key, required this.userAnswers});
  final Map<String, dynamic> userAnswers;
  @override
  Widget build(BuildContext context) {
    return ExamScreen(
      precent: 7,
      hasTime: true,
      userAnswers: userAnswers,
      appBarTitle: AppString.postExamTitle,
      collectionName: AppString.postExamCollection,
      examQuestions: postExamQuestions,
      // rightAnswers: postExamAnswers,
      showQuestionButton: true,
      endTime: DateTime.now().add(
        const Duration(
          hours: 1,
          minutes: 0,
          seconds: 0,
        ),
      ),
    );
  }
}
