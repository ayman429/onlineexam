// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

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
  },
  {
    1: [
      {"q": "i6eq1", "a": 0, "rate": 2},
      {"q": "i6eq2", "a": 1, "rate": 1}
    ],
    2: [
      {"q": "i6mq1", "a": 2, "rate": 4},
      {"q": "i6mq2", "a": 3, "rate": 3}
    ],
    3: [
      {"q": "i6hq1", "a": 4, "rate": 6},
      {"q": "i6hq2", "a": 5, "rate": 5}
    ],
  }
];

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  getQuestion() {
    int rightAnswer = x[item][level][questionNumber]["a"];
    if (userAnser == rightAnswer) {
      if (level == 2) {
        medium++;
        levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
        level++;
        questionNumber = levelQNumber[level - 1];
      } else if (level == 3) {
        hard++;
        item++;
        levelQNumber = [0, 0, 0];
        level = 2;
        questionNumber = 0;
      } else if (level == 1) {
        easy++;
        if (levelQNumber[1] == 2) {
          item++;
          levelQNumber = [0, 0, 0];
          level = 2;
          questionNumber = 0;
        } else {
          levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
          level++;
          questionNumber = levelQNumber[level - 1];
        }
      }
      print("true");
      // questionNumber = levelQNumber[level - 1];
    } else {
      if (level == 2) {
        if (levelQNumber[0] == 2) {
          item++;
          levelQNumber = [0, 0, 0];
          level = 2;
          questionNumber = 0;
        } else {
          levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
          level--;
          questionNumber = levelQNumber[level - 1];
        }
      } else if (level == 3) {
        if (levelQNumber[level - 1] == 1) {
          item++;
          levelQNumber = [0, 0, 0];
          level = 2;
          questionNumber = 0;
        } else {
          levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
          if (levelQNumber[1] == 2) {
          } else {
            level--;
          }
          questionNumber = levelQNumber[level - 1];
        }
      } else if (level == 1) {
        if (levelQNumber[level - 1] == 1) {
          item++;
          levelQNumber = [0, 0, 0];
          level = 2;
          questionNumber = 0;
        } else {
          levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
          questionNumber = levelQNumber[level - 1];
        }
      }
      // questionNumber = levelQNumber[level - 1];
      print("false");
    }
    if (itemCount == item - 1) {
      if (hard == 1) {
        itemScore = 20;
      } else if (medium >= 1) {
        itemScore = 10;
      } else if (easy >= 1) {
        itemScore = 5;
      } else {
        itemScore = 0;
      }
      itemCount++;
      totalScore = totalScore + itemScore;
      itemScore = 0;
    }
    setState(() {});
  }

  int item = 0, level = 2, questionNumber = 0;
  List levelQNumber = [0, 0, 0];
  int userAnser = 0;
  int easy = 0,
      medium = 0,
      hard = 0,
      itemCount = 0,
      itemScore = 0,
      totalScore = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000518),
      appBar: AppBar(
        backgroundColor: const Color(0xFF62FCD7),
        title: const Text(
          "Exam",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              setState(() {
                userAnser = int.parse(value);
              });
              getQuestion();
              // int rightAnswer = x[item][level][questionNumber]["a"];
              // if (userAnser == rightAnswer) {
              //   if (level == 2) {
              //     medium++;
              //     levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
              //     level++;
              //     questionNumber = levelQNumber[level - 1];
              //   } else if (level == 3) {
              //     hard++;
              //     item++;
              //     levelQNumber = [0, 0, 0];
              //     level = 2;
              //     questionNumber = 0;
              //   } else if (level == 1) {
              //     easy++;
              //     if (levelQNumber[1] == 2) {
              //       item++;
              //       levelQNumber = [0, 0, 0];
              //       level = 2;
              //       questionNumber = 0;
              //     } else {
              //       levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
              //       level++;
              //       questionNumber = levelQNumber[level - 1];
              //     }
              //   }
              //   print("true");
              //   // questionNumber = levelQNumber[level - 1];
              // } else {
              //   if (level == 2) {
              //     if (levelQNumber[0] == 2) {
              //       item++;
              //       levelQNumber = [0, 0, 0];
              //       level = 2;
              //       questionNumber = 0;
              //     } else {
              //       levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
              //       level--;
              //       questionNumber = levelQNumber[level - 1];
              //     }
              //   } else if (level == 3) {
              //     if (levelQNumber[level - 1] == 1) {
              //       item++;
              //       levelQNumber = [0, 0, 0];
              //       level = 2;
              //       questionNumber = 0;
              //     } else {
              //       levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
              //       if (levelQNumber[1] == 2) {
              //       } else {
              //         level--;
              //       }
              //       questionNumber = levelQNumber[level - 1];
              //     }
              //   } else if (level == 1) {
              //     if (levelQNumber[level - 1] == 1) {
              //       item++;
              //       levelQNumber = [0, 0, 0];
              //       level = 2;
              //       questionNumber = 0;
              //     } else {
              //       levelQNumber[level - 1] = levelQNumber[level - 1] + 1;
              //       questionNumber = levelQNumber[level - 1];
              //     }
              //   }
              //   // questionNumber = levelQNumber[level - 1];
              //   print("false");
              // }
              // if (itemCount == item - 1) {
              //   if (hard == 1) {
              //     itemScore = 20;
              //   } else if (medium >= 1) {
              //     itemScore = 10;
              //   } else if (easy >= 1) {
              //     itemScore = 5;
              //   } else {
              //     itemScore = 0;
              //   }
              //   itemCount++;
              //   totalScore = totalScore + itemScore;
              //   itemScore = 0;
              // }
              // setState(() {});
              print("levelQNumber: $levelQNumber");
              print(
                  "item: $item, level: $level, questionNumber: $questionNumber");
            },
          ),
          const SizedBox(height: 20),
          item == x.length
              ? const Text("End")
              : Text("${x[item][level][questionNumber]["q"]}"),
          // const SizedBox(height: 20),
          // Text("itemScore: $itemScore"),
          const SizedBox(height: 20),
          Text("totalScore: $totalScore"),
          // const Text(
          //     "الوظيفة الأساسية لـ 'توازن اللون الأبيض (White Balance)' في التصوير الفوتوغرافي هي..............."),
        ],
      ),
    );
  }
}
