import '../../core/constant/app_string.dart';

Map<String, dynamic> calculateHMEpercentage(userAnswersExamAnalysis) {
  int easy = 0;
  int medium = 0;
  int hard = 0;
  int wrong = 0;
  int notAnswered = 0;
  for (int i = 0; i < userAnswersExamAnalysis["levelDetails"].length; i++) {
    if (userAnswersExamAnalysis["levelDetails"][i] == AppString.easyDegree) {
      easy++;
    } else if (userAnswersExamAnalysis["levelDetails"][i] ==
        AppString.mediumDegree) {
      medium++;
    } else if (userAnswersExamAnalysis["levelDetails"][i] ==
        AppString.hardDegree) {
      hard++;
    } else if (userAnswersExamAnalysis["levelDetails"][i] ==
        AppString.falseDegree) {
      wrong++;
    } else {
      notAnswered++;
    }
  }
  Map<String, dynamic> levelDetails = {
    "hard":
        ((hard / userAnswersExamAnalysis["levelDetails"].length) * 100).round(),
    "medium": ((medium / userAnswersExamAnalysis["levelDetails"].length) * 100)
        .round(),
    "easy":
        ((easy / userAnswersExamAnalysis["levelDetails"].length) * 100).round(),
    "wrong": ((wrong / userAnswersExamAnalysis["levelDetails"].length) * 100)
        .round(),
    "notAnswered":
        ((notAnswered / userAnswersExamAnalysis["levelDetails"].length) * 100)
            .round(),
    "examPercentage": (((hard + medium + easy) /
                userAnswersExamAnalysis["levelDetails"].length) *
            100)
        .round(),
  };
  return levelDetails;
}
