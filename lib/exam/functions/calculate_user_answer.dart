import '../../core/exams/0_pre_exam.dart';
import '../../core/firebase/firebase_get_users_answer_pre_post_exam.dart';

calculateUserAnswer({
  required String collectionName,
}) async {
  List<Map<String, dynamic>> prePostExamUserAnswer =
      await getUsersAnswerPrePostExam(collectionName: collectionName);
  int a1 = 0, a2 = 0, a3 = 0, a4 = 0, a0 = 0;
  Map<int, dynamic> userAnswersCount = {};
  if (prePostExamUserAnswer.length > 0) {
    for (int i = 0; i < preExamAnswers.length; i++) {
      for (int j = 0; j < prePostExamUserAnswer.length; j++) {
        // print(prePostExamUserAnswer[i]);
        switch (prePostExamUserAnswer[j]["answer"][i]) {
          case 0:
            a0++;
            break;
          case 1:
            a1++;
            break;
          case 2:
            a2++;
            break;
          case 3:
            a3++;
            break;
          case 4:
            a4++;
            break;
        }
      }
      userAnswersCount.addAll({
        i: {"a0": a0, "a1": a1, "a2": a2, "a3": a3, "a4": a4}
      });
      a0 = 0;
      a1 = 0;
      a2 = 0;
      a3 = 0;
      a4 = 0;
    }
  }
  // print(userAnswersCount);
  return userAnswersCount;
}
