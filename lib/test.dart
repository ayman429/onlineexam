List x = [
  {
    1: [
      {"q": "eq1", "a": 0, "rate": 2},
      {"q": "eq2", "a": 1, "rate": 1}
    ],
    2: [
      {"q": "mq1", "a": 2, "rate": 4},
      {"q": "mq2", "a": 3, "rate": 3}
    ],
    3: [
      {"q": "hq1", "a": 4, "rate": 6},
      {"q": "hq2", "a": 5, "rate": 5}
    ],
  },
  {
    1: [
      {"q": "eq1", "a": 0, "rate": 2},
      {"q": "eq2", "a": 1, "rate": 1}
    ],
    2: [
      {"q": "mq1", "a": 2, "rate": 4},
      {"q": "mq2", "a": 3, "rate": 3}
    ],
    3: [
      {"q": "hq1", "a": 4, "rate": 6},
      {"q": "hq2", "a": 5, "rate": 5}
    ],
  }
];

Map getQuestion(
    {required int item, required int level, required int questionNumber}) {
  Map q = x[item][level][questionNumber];
  return q;
}

int main() {
  int easy = 0, medium = 0, hard = 0, item = 0, level = 2, questionNumber = 0;
  int userAnser = 0;
  userAnser = 2; //mT
  int rightAnswer = getQuestion(
      item: item, level: level, questionNumber: questionNumber)["a"];
  if (userAnser == rightAnswer) {
    if (level == 2) {
      medium++;
      level++;
    }
    if (level == 3) {
      item++;
      easy = 0;
      medium = 0;
      hard = 0;
      item = 0;
      level = 2;
      questionNumber = 0;
    }
    if (level == 1) {}
  } else {
    if (level == 2) {
      medium++;
      level++;
    }
    if (level == 3) {
      hard++;
    }
    if (level == 1) {}
  }
  print(getQuestion(
      item: item, level: level, questionNumber: questionNumber)["q"]);
  return 0;
}
