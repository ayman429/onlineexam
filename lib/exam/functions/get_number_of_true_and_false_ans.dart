Map<String, int> getNumberOfTrueAndFalseAns(
    {required List<int> userAnswers, required List<int> rightAnswers}) {
  Map<String, int> result;
  int trueLength = 0;
  int falseLength = 0;
  for (int i = 0; i < rightAnswers.length; i++) {
    if (userAnswers[i] == rightAnswers[i]) {
      trueLength++;
    } else {
      falseLength++;
    }
  }
  result = {'true': trueLength, 'false': falseLength};
  return result;
}
