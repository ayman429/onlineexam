import '../../core/constant/app_string.dart';

Map<String, dynamic> calculateScore(
    {required List<int> userAnswers,
    required List<int> rightAnswers,
    required List<Map> examQuestions}) {
  int totalScore = 0;
  int exam1Score = 0;
  int exam2Score = 0;
  int exam3Score = 0;
  int exam4Score = 0;
  int exam5Score = 0;
  int remember = 0,
      understand = 0,
      application = 0,
      analysis = 0,
      evaluation = 0;

  Map<String, dynamic> userAnswersData;
  for (int i = 0; i < rightAnswers.length; i++) {
    if (userAnswers[i] == rightAnswers[i]) {
      switch (examQuestions[i]["type"]) {
        case 1:
          exam1Score++;
          break;
        case 2:
          exam2Score++;
          break;
        case 3:
          exam3Score++;
          break;
        case 4:
          exam4Score++;
          break;
        case 5:
          exam5Score++;
          break;
        default:
      }
      switch (examQuestions[i]["level"]) {
        case AppString.remember:
          totalScore += 10;
          remember++;
          break;
        case AppString.understand:
          totalScore += 15;
          understand++;
          break;
        case AppString.application:
          totalScore += 20;
          application++;
          break;
        case AppString.analysis:
          totalScore += 20;
          analysis++;
          break;
        case AppString.evaluation:
          totalScore += 20;
          evaluation++;
          break;
      }
    }
  }
  userAnswersData = {
    "totalScore": totalScore,
    "exam1Score": exam1Score,
    "exam2Score": exam2Score,
    "exam3Score": exam3Score,
    "exam4Score": exam4Score,
    "exam5Score": exam5Score,
    "remember": remember,
    "understand": understand,
    "application": application,
    "analysis": analysis,
    "evaluation": evaluation
  };
  return userAnswersData;
}
