import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:onlineexam/core/exams/0_pre_exam.dart';
import 'package:onlineexam/exam/home.dart';
// import 'package:percent_indicator/percent_indicator.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_string.dart';
import '../../core/exams/6_post_exam.dart';
import '../../core/firebase/firebase_add_exam_data.dart';
import '../../core/firebase/firebase_get_doc_percent.dart';
import '../../core/firebase/firebase_get_user_answer.dart';
import '../../core/firebase/firebase_update_exam_data.dart';
import '../../core/firebase/firebase_update_user_info.dart';
import '../functions/calculate_score.dart';
import 'questions_ui.dart';
import 'score_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen(
      {super.key,
      required this.examQuestions,
      required this.appBarTitle,
      // required this.rightAnswers,
      required this.collectionName,
      this.endTime,
      required this.userAnswers,
      required this.hasTime,
      required this.showQuestionButton,
      required this.precent,
      this.examLength});
  final List<Map> examQuestions;
  // final List<int> rightAnswers;
  final String appBarTitle;
  final String collectionName;
  final DateTime? endTime;
  final Map<String, dynamic> userAnswers;
  final bool hasTime;
  final bool showQuestionButton;
  final int precent;
  final int? examLength;

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
  List<int> radioValue = [];
  List<int> radioValueSaved = [];
  // List<int> lineValue = [];
  List<int> questionNumberState = [];
  int index = 0;
  String subDocId = "";
  DateTime endExamTime = DateTime(0);
  bool isShowAnswer = false;
  bool isSaved = false;
  // int solve = 0;

  Future<void> saveChanged() async {
    // print("====================================");
    // Map<String, dynamic> userAnswers = {};
    // try {
    //   userAnswers = await getUserAnswer(collectionName: widget.collectionName);
    // } catch (e) {
    //   // print(e);
    // }

    if (widget.userAnswers.entries.isNotEmpty) {
      widget.showQuestionButton
          ? radioValue = widget.userAnswers["answer"].cast<int>()
          : null;
      widget.showQuestionButton
          ? radioValueSaved = widget.userAnswers["answer"].cast<int>()
          : null;
      widget.showQuestionButton
          ? questionNumberState =
              widget.userAnswers["questionNumberState"].cast<int>()
          // : index = widget.userAnswers["questionIndex"];
          : null;
      subDocId = widget.userAnswers["id"];
      if (widget.showQuestionButton) {
      } else {
        index = widget.userAnswers["index"];
        isShowAnswer = widget.userAnswers["isShowAnswer"];
        radioValue[index] = widget.userAnswers["radioValueI"];
        //
        levelDetails.addAll(widget.userAnswers["levelDetails"]);
        item = widget.userAnswers["item"];
        level = widget.userAnswers["level"];
        questionNumber = widget.userAnswers["questionNumber"];
        levelQNumber = widget.userAnswers["levelQNumber"];
        userAnser = widget.userAnswers["userAnser"];
        easy = widget.userAnswers["easy"];
        medium = widget.userAnswers["medium"];
        hard = widget.userAnswers["hard"];
        itemCount = widget.userAnswers["itemCount"];
        itemScore = widget.userAnswers["itemScore"];
        totalScore = widget.userAnswers["totalScore"];
      }
      if (widget.hasTime) {
        Timestamp dateTime = widget.userAnswers["startTime"];
        Timestamp now = Timestamp.fromDate(DateTime.now());

        var dif = now.seconds - dateTime.seconds;
        dif = dif > 3600 ? 3600 : dif;
        var time = DateTime.now().add(
          Duration(seconds: 3600 - dif),
        );
        endExamTime = time;

        dif - 3600 == 0
            ? endExamTime = DateTime.now().add(
                const Duration(seconds: 1),
              )
            : null;
      }

      setState(() {});
    } else {
      // print("radioValue: $radioValue");
      addExamData(
        collectionName: widget.collectionName,
        data: widget.showQuestionButton
            ? {
                "answer": radioValueSaved,
                "questionNumberState": questionNumberState,
                "score": 0,
                "userAnswersData": {},
                "startTime": DateTime.now(),
                "endTime": DateTime.now(),
                "isFinished": false,
              }
            : {
                "index": index,
                "isShowAnswer": isShowAnswer,
                "radioValueI": radioValue[index],
                //
                "levelDetails": levelDetails,
                "item": item,
                "level": level,
                "questionNumber": questionNumber,
                "levelQNumber": levelQNumber,
                "userAnser": userAnser,
                "easy": easy,
                "medium": medium,
                "hard": hard,
                "itemCount": itemCount,
                "itemScore": itemScore,
                "totalScore": totalScore,
                "startTime": DateTime.now(),
                "endTime": DateTime.now(),
                "isFinished": false,
              },
      );
      Map<String, dynamic> userAnswers = await getUserAnswer(
          docUserId: "",
          collectionName: widget.collectionName,
          showQuestionButton: widget.showQuestionButton);
      subDocId = userAnswers["id"];
      setState(() {});
    }
  }

  int item = 0, level = 2, questionNumber = 0;
  List levelQNumber = [0, 0, 0], levelDetails = [];
  int userAnser = 0;
  int easy = 0,
      medium = 0,
      hard = 0,
      itemCount = 0,
      itemScore = 0,
      totalScore = 0;
  getQuestion() {
    int rightAnswer = widget.examQuestions[item][level][questionNumber]["a"];
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
        itemScore = AppString.hardDegree;
        levelDetails[item - 1] = itemScore;
      } else if (medium >= 1) {
        itemScore = AppString.mediumDegree;
        levelDetails[item - 1] = itemScore;
      } else if (easy >= 1) {
        itemScore = AppString.easyDegree;
        levelDetails[item - 1] = itemScore;
      } else {
        itemScore = AppString.falseDegree;
        levelDetails[item - 1] = itemScore;
      }
      itemCount++;
      totalScore = totalScore + itemScore;
      itemScore = 0;
      hard = 0;
      medium = 0;
      easy = 0;
    }
    userAnser = 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    radioValue.addAll(List.generate(
        widget.showQuestionButton
            ? widget.examQuestions.length
            : widget.examQuestions.length * 6,
        (i) => 0));
    radioValueSaved.addAll(List.generate(
        widget.showQuestionButton
            ? widget.examQuestions.length
            : widget.examQuestions.length * 6,
        (i) => 0));
    // lineValue.addAll(List.generate(widget.examQuestions.length, (index) => -1));
    widget.showQuestionButton
        ? questionNumberState
            .addAll(List.generate(widget.examQuestions.length, (index) => -1))
        : levelDetails
            .addAll(List.generate(widget.examQuestions.length, (i) => -1));
    widget.hasTime ? endExamTime = widget.endTime! : null;
    saveChanged();
    print(radioValue);
  }

  Color getColor(int questionIndex) {
    if (questionNumberState[questionIndex] == 1) {
      return Colors.green;
    } else if (questionNumberState[questionIndex] == 0) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor3,
        surfaceTintColor: AppColor.backgroundColor3,
        shadowColor: const Color(0xFFc9d3de),
        elevation: 4,
        title: Text(
          widget.appBarTitle,
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: widget.precent == 1 || widget.precent == 7
                  ? MediaQuery.sizeOf(context).width * 0.08
                  : MediaQuery.sizeOf(context).width * 0.045,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.backgroundColor3,
              ),
              onPressed: () async {
                int percentValue = 0;
                try {
                  // int score = 0;
                  Map<String, dynamic> userAnswersData = {};
                  if (widget.showQuestionButton) {
                    userAnswersData = calculateScore(
                        userAnswers: radioValueSaved,
                        examQuestions: widget.examQuestions,
                        rightAnswers: widget.precent == 1
                            ? preExamAnswers
                            : postExamAnswers);
                  }
                  percentValue = await getDocPercent();
                  percentValue = percentValue + 1;
                  updateUserData(percent: percentValue);
                  // if (widget.precent == 1) {
                  //   updateUserData(percent: widget.precent);
                  // } else if (widget.precent == 7) {
                  //   updateUserData(percent: widget.precent);
                  // } else {
                  //   updateUserData(percent: ++percentValue);
                  // }
                  // int score = 0;
                  // if (widget.showQuestionButton) {
                  //   score = calculateScore(
                  //       userAnswers: radioValue,
                  //       rightAnswers: widget.precent == 1
                  //           ? preExamAnswers
                  //           : postExamAnswers);
                  // }
                  updateExamData(
                    collectionName: widget.collectionName,
                    subDocId: subDocId,
                    data: widget.showQuestionButton
                        ? {
                            "answer": radioValueSaved,
                            "questionNumberState": FieldValue.delete(),
                            "score": userAnswersData["totalScore"],
                            "userAnswersData": userAnswersData,
                            "endTime": DateTime.now(),
                            "isFinished": true,
                          }
                        : {
                            "totalScore": totalScore +
                                ((widget.examLength! -
                                        widget.examQuestions.length) *
                                    20),
                            "endTime": DateTime.now(),
                            "isFinished": true,
                            // -------------------------
                            "index": FieldValue.delete(),
                            "isShowAnswer": FieldValue.delete(),
                            "radioValueI": FieldValue.delete(),
                            "item": FieldValue.delete(),
                            "level": FieldValue.delete(),
                            "questionNumber": FieldValue.delete(),
                            "levelQNumber": FieldValue.delete(),
                            "userAnser": FieldValue.delete(),
                            "easy": FieldValue.delete(),
                            "medium": FieldValue.delete(),
                            "hard": FieldValue.delete(),
                            "itemCount": FieldValue.delete(),
                            "itemScore": FieldValue.delete(),
                          },
                  );
                } catch (e) {
                  print(e);
                }
                // updateUserData(percent: widget.precent);
                // int precent = await getDocPercent();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(precent: percentValue),
                    ),
                    (route) => false);
              },
              child: const Text(
                AppString.finshExam,
                style: TextStyle(
                    color: AppColor.textColor3,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: widget.precent == 1
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          widget.showQuestionButton
              ? Container(
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: const BoxDecoration(
                    color: AppColor.backgroundColor3,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFc9d3de),
                        blurRadius: 6,
                        spreadRadius: 4,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: widget.examQuestions.length,
                    itemBuilder: (context, questionIndex) {
                      return QuestionNumberButton(
                        number: questionIndex + 1,
                        color: getColor(questionIndex),
                        onPressed: () {
                          setState(() {
                            print(index);
                            questionNumberState[index] == 1
                                ? null
                                : isSaved
                                    ? null
                                    : questionNumberState[index] = 0;
                            index = questionIndex;
                            isSaved = false;
                          });
                          updateExamData(
                            collectionName: widget.collectionName,
                            subDocId: subDocId,
                            data: {
                              // "answer": radioValue,
                              "questionNumberState": questionNumberState,
                              // "score": 0,
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  widget.hasTime
                      ? TimerCountdown(
                          hoursDescription: "ساعة",
                          minutesDescription: "دقيقة",
                          secondsDescription: "ثانية",
                          timeTextStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor3),
                          format: CountDownTimerFormat.hoursMinutesSeconds,
                          endTime: endExamTime,
                          onTick: (remainingTime) {
                            // if (remainingTime.inMinutes == 5) {
                            //   // showDialog(context: context, builder: builder);
                            // }
                            // print("Remaining Time: $remainingTime");
                          },
                          onEnd: () async {
                            int percentValue = 0;
                            try {
                              // int score = 0;
                              // if (widget.showQuestionButton) {
                              //   score = calculateScore(
                              //       userAnswers: radioValue,
                              //       rightAnswers: widget.precent == 1
                              //           ? preExamAnswers
                              //           : postExamAnswers);
                              // }
                              percentValue = await getDocPercent();
                              percentValue = percentValue + 1;
                              updateUserData(percent: percentValue);
                              // if (widget.precent == 1) {
                              //   updateUserData(percent: widget.precent);
                              //   precent=widget.precent;
                              // } else if (widget.precent == 7) {
                              //   updateUserData(percent: widget.precent);
                              //    precent=widget.precent;
                              // } else {
                              //   updateUserData(percent: ++percentValue);
                              //    precent=widget.precent;
                              // }
                              Map<String, dynamic> userAnswersData = {};
                              if (widget.showQuestionButton) {
                                userAnswersData = calculateScore(
                                    userAnswers: radioValue,
                                    examQuestions: widget.examQuestions,
                                    rightAnswers: widget.precent == 1
                                        ? preExamAnswers
                                        : postExamAnswers);
                              }
                              updateExamData(
                                  collectionName: widget.collectionName,
                                  subDocId: subDocId,
                                  data: {
                                    // "answer": radioValue,
                                    "questionNumberState": FieldValue.delete(),
                                    "score": userAnswersData["totalScore"],
                                    "userAnswersData": userAnswersData,
                                    "endTime": DateTime.now(),
                                    "isFinished": true,
                                  });
                            } catch (e) {
                              print(e);
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Center(
                                child: Text("انتهى الوقت تم حفظ الاجابات",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                              ),
                              duration: Duration(seconds: 2),
                            ));
                            // updateUserData(percent: widget.precent);

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(precent: percentValue)));

                            print("Timer finished");
                          },
                        )
                      : const SizedBox(),
                  widget.hasTime
                      ? const SizedBox(height: 40)
                      : const SizedBox(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.showQuestionButton
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColor.backgroundColor4,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFc9d3de),
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: IntrinsicWidth(
                                child: Row(
                                  children: [
                                    const Text(
                                      "نقاطك",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.textColor3),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFb1feb1), //AppColor.backgroundColor4,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "$totalScore",
                                        style: const TextStyle(
                                            color: AppColor.textColor3,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      widget.showQuestionButton
                          ? const SizedBox()
                          : const SizedBox(height: 20),
                      widget.showQuestionButton
                          ? const SizedBox()
                          : item == widget.examQuestions.length
                              ? const SizedBox()
                              : Text(
                                  "المستوى: ${widget.examQuestions[item][level][questionNumber]["Level"]}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textColor1),
                                ),
                      widget.showQuestionButton
                          ? const SizedBox()
                          : const SizedBox(height: 20),
                      item == widget.examQuestions.length
                          ? const Text(
                              "انتهت الاسئلة",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textColor1),
                            )
                          : QuestionsUi(
                              isShowAnswer: isShowAnswer,
                              showQuestionButton: widget.showQuestionButton,
                              examQuestions: widget.showQuestionButton
                                  ? widget.examQuestions[index]
                                  : widget.examQuestions[item][level]
                                      [questionNumber],
                              index: index,
                              radioValue: radioValue[index],
                              isAnswered: false,
                              // rightAnswer: widget.rightAnswers[index],
                              onChanged: isShowAnswer
                                  ? (value) {}
                                  : (value) {
                                      setState(() {
                                        radioValue[index] = value!;

                                        // widget.showQuestionButton
                                        //     ? questionNumberState[index] = 1
                                        //     : null;
                                      });
                                    },
                            ),

                      //  widget.examQuestions[index]["T"]
                      item == widget.examQuestions.length
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor:
                                            AppColor.backgroundColor3,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                      ),
                                      onPressed: isShowAnswer
                                          ? null
                                          : () async {
                                              setState(() {
                                                widget.showQuestionButton
                                                    ? null
                                                    : isShowAnswer = true;
                                                widget.showQuestionButton
                                                    ? radioValue[index] == 0
                                                        ? questionNumberState[
                                                            index] = 0
                                                        : questionNumberState[
                                                            index] = 1
                                                    : userAnser =
                                                        radioValue[index];

                                                // radioValue.add(0);
                                                // index == widget.examQuestions.length - 1
                                                //     ? null
                                                //     : index++;
                                                isSaved = true;
                                                radioValueSaved[index] =
                                                    radioValue[index];
                                              });

                                              try {
                                                print("============ 1");
                                                await updateExamData(
                                                  collectionName:
                                                      widget.collectionName,
                                                  subDocId: subDocId,
                                                  data: widget
                                                          .showQuestionButton
                                                      ? {
                                                          "answer":
                                                              radioValueSaved,
                                                          "questionNumberState":
                                                              questionNumberState,
                                                          "score": 0,
                                                        }
                                                      : {
                                                          "index": index,
                                                          "isShowAnswer":
                                                              isShowAnswer,
                                                          "radioValueI":
                                                              radioValue[index],
                                                          //
                                                          "item": item,
                                                          "level": level,
                                                          "questionNumber":
                                                              questionNumber,
                                                          "levelQNumber":
                                                              levelQNumber,
                                                          "userAnser":
                                                              userAnser,
                                                          "easy": easy,
                                                          "medium": medium,
                                                          "hard": hard,
                                                          "itemCount":
                                                              itemCount,
                                                          "itemScore":
                                                              itemScore,
                                                          "totalScore":
                                                              totalScore,
                                                          "levelDetails":
                                                              levelDetails,
                                                        },
                                                );
                                                print("============ 2");
                                              } catch (e) {
                                                print("============ e = ${e}");
                                              }
                                            },
                                      child: Text(
                                        "حفظ",
                                        style: TextStyle(
                                            color: isShowAnswer
                                                ? Colors.grey
                                                : AppColor.textColor3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      widget.showQuestionButton
                          ? const SizedBox()
                          : isShowAnswer
                              ? Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              "التغذية الراجعة",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.textColor3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 20),
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 20,
                                                    left: 20,
                                                    right: 20),
                                                decoration: const BoxDecoration(
                                                  color:
                                                      AppColor.backgroundColor4,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(0),
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFFc9d3de),
                                                      blurRadius: 6,
                                                      spreadRadius: 4,
                                                      offset: Offset(2, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        bottom: 10,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .backgroundColor1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0xFFc9d3de),
                                                            blurRadius: 6,
                                                            spreadRadius: 4,
                                                            offset:
                                                                Offset(2, 4),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        radioValue[index] ==
                                                                widget.examQuestions[
                                                                            item]
                                                                        [level][
                                                                    questionNumber]["a"]
                                                            ? "إجابة صحيحة"
                                                            : "إجابة خاطئة",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: radioValue[
                                                                      index] ==
                                                                  widget.examQuestions[
                                                                              item]
                                                                          [
                                                                          level]
                                                                      [
                                                                      questionNumber]["a"]
                                                              ? AppColor.iconColor3
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    radioValue[index] ==
                                                            widget.examQuestions[
                                                                    item][level]
                                                                [
                                                                questionNumber]["a"]
                                                        ? Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Text(
                                                              "الإجابة صحيحة: ${widget.examQuestions[item][level][questionNumber]["T"]}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: AppColor
                                                                    .textColor1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          )
                                                        : Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  "الإجابة الصحيحة هي:  ${widget.examQuestions[item][level][questionNumber]["A${widget.examQuestions[item][level][questionNumber]["a"]}"]}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: AppColor
                                                                        .textColor3,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  "${widget.examQuestions[item][level][questionNumber]["T"]}",
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: AppColor
                                                                        .textColor1,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  getQuestion();

                                                  isShowAnswer = false;
                                                  index ==
                                                          widget.examQuestions
                                                                      .length *
                                                                  6 -
                                                              1
                                                      ? null
                                                      : index++;
                                                  updateExamData(
                                                    collectionName:
                                                        widget.collectionName,
                                                    subDocId: subDocId,
                                                    data: {
                                                      "index": index,
                                                      "isShowAnswer":
                                                          isShowAnswer,
                                                      "radioValueI":
                                                          radioValue[index],
                                                      //
                                                      "item": item,
                                                      "level": level,
                                                      "questionNumber":
                                                          questionNumber,
                                                      "levelQNumber":
                                                          levelQNumber,
                                                      "userAnser": userAnser,
                                                      "easy": easy,
                                                      "medium": medium,
                                                      "hard": hard,
                                                      "itemCount": itemCount,
                                                      "itemScore": itemScore,
                                                      "totalScore": totalScore,
                                                      "levelDetails":
                                                          levelDetails,
                                                    },
                                                  );
                                                });
                                              },
                                              icon: Transform.rotate(
                                                angle: 1.57,
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 30,
                                                  color: AppColor.textColor3,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                      const SizedBox(height: 40),

                      // Padding(
                      //   padding:
                      //       const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CustomButtonNextBackScreen(
                      //         icon: Icons.arrow_back_ios_new,
                      //         color:
                      //             index == widget.examQuestions.length - 1
                      //                 ? Colors.grey
                      //                 : const Color(0xFF62FCD7),
                      //         onPressed: index ==
                      //                 widget.examQuestions.length - 1
                      //             ? null
                      //             : () {
                      //                 setState(() {
                      //                   radioValue[index] == 0
                      //                       ? questionNumberState[index] =
                      //                           0
                      //                       : null;
                      //                   // radioValue.add(0);
                      //                   index++;
                      //                 });
                      //                 updateExamData(
                      //                   collectionName:
                      //                       widget.collectionName,
                      //                   subDocId: subDocId,
                      //                   data: {
                      //                     "answer": radioValue,
                      //                     "questionNumberState":
                      //                         questionNumberState,
                      //                     "score": 0,
                      //                   },
                      //                 );
                      //               },
                      //       ),
                      //       Text(
                      //         "${index + 1}",
                      //         style: const TextStyle(
                      //             color: Color(0xFF62FCD7),
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //       CustomButtonNextBackScreen(
                      //         icon: Icons.arrow_forward_ios,
                      //         color: index == 0
                      //             ? Colors.grey
                      //             : const Color(0xFF62FCD7),
                      //         onPressed: index <= 0
                      //             ? null
                      //             : () {
                      //                 setState(() {
                      //                   radioValue[index] == 0
                      //                       ? questionNumberState[index] =
                      //                           0
                      //                       : null;
                      //                   index--;
                      //                 });
                      //                 updateExamData(
                      //                   collectionName:
                      //                       widget.collectionName,
                      //                   subDocId: subDocId,
                      //                   data: {
                      //                     "answer": radioValue,
                      //                     "questionNumberState":
                      //                         questionNumberState,
                      //                     "score": 0,
                      //                   },
                      //                 );
                      //               },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//   double linePercentValue() {
//     if (radioValue[index] != 0 && !lineValue.contains(index)) {
//       lineValue.add(index);
//       if (solve < widget.examQuestions.length) {
//         return ++solve / widget.examQuestions.length;
//       } else {
//         return 1;
//       }
//     } else {
//       return solve / widget.examQuestions.length;
//     }
//   }
}

class QuestionNumberButton extends StatelessWidget {
  const QuestionNumberButton({
    super.key,
    required this.number,
    this.onPressed,
    required this.color,
  });
  final int number;
  final Color color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 40,
        width: 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all<Color>(Colors.grey),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            backgroundColor: WidgetStatePropertyAll(color),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
