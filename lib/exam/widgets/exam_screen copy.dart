// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
// // import 'package:percent_indicator/percent_indicator.dart';

// import '../../core/constant/app_color.dart';
// import '../../core/constant/app_string.dart';
// import '../../core/firebase/firebase_add_exam_data.dart';
// import '../../core/firebase/firebase_get_user_answer.dart';
// import '../../core/firebase/firebase_update_exam_data.dart';
// import '../../core/firebase/firebase_update_user_info.dart';
// import '../functions/calculate_score.dart';
// import 'questions_ui.dart';
// import 'score_screen.dart';

// class ExamScreen extends StatefulWidget {
//   const ExamScreen(
//       {super.key,
//       required this.examQuestions,
//       required this.appBarTitle,
//       required this.rightAnswers,
//       required this.collectionName,
//       this.endTime,
//       required this.userAnswers,
//       required this.hasTime,
//       required this.showQuestionButton,
//       required this.precent});
//   final List<Map<String, dynamic>> examQuestions;
//   final List<int> rightAnswers;
//   final String appBarTitle;
//   final String collectionName;
//   final DateTime? endTime;
//   final Map<String, dynamic> userAnswers;
//   final bool hasTime;
//   final bool showQuestionButton;
//   final int precent;

//   @override
//   State<ExamScreen> createState() => _ExamScreenState();
// }

// class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
//   List<int> radioValue = [];
//   // List<int> lineValue = [];
//   List<int> questionNumberState = [];
//   int index = 0;
//   String subDocId = "";
//   DateTime endExamTime = DateTime(0);
//   bool isShowAnswer = false;
//   // int solve = 0;

//   Future<void> saveChanged() async {
//     // print("====================================");
//     // Map<String, dynamic> userAnswers = {};
//     // try {
//     //   userAnswers = await getUserAnswer(collectionName: widget.collectionName);
//     // } catch (e) {
//     //   // print(e);
//     // }

//     if (widget.userAnswers.entries.isNotEmpty) {
//       radioValue = widget.userAnswers["answer"].cast<int>();
//       widget.showQuestionButton
//           ? questionNumberState =
//               widget.userAnswers["questionNumberState"].cast<int>()
//           : index = widget.userAnswers["questionIndex"];
//       subDocId = widget.userAnswers["id"];
//       if (widget.hasTime) {
//         Timestamp dateTime = widget.userAnswers["time"];
//         Timestamp now = Timestamp.fromDate(DateTime.now());

//         var dif = now.seconds - dateTime.seconds;
//         dif = dif > 3600 ? 3600 : dif;
//         var time = DateTime.now().add(
//           Duration(seconds: 3600 - dif),
//         );
//         endExamTime = time;

//         dif - 3600 == 0
//             ? endExamTime = DateTime.now().add(
//                 const Duration(seconds: 1),
//               )
//             : null;
//       }

//       setState(() {});
//     } else {
//       // print("radioValue: $radioValue");
//       addExamData(
//         collectionName: widget.collectionName,
//         data: widget.showQuestionButton
//             ? {
//                 "answer": radioValue,
//                 "questionNumberState": questionNumberState,
//                 "score": 0,
//                 "startTime": DateTime.now(),
//                 "endTime": DateTime.now(),
//                 "isFinished": false,
//               }
//             : {
//                 "answer": radioValue,
//                 // "questionNumberState": questionNumberState,
//                 "questionIndex": 0,
//                 "score": 0,
//                 "startTime": DateTime.now(),
//                 "endTime": DateTime.now(),
//                 "isFinished": false,
//               },
//       );
//       Map<String, dynamic> userAnswers = await getUserAnswer(
//           collectionName: widget.collectionName,
//           showQuestionButton: widget.showQuestionButton);
//       subDocId = userAnswers["id"];
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     radioValue.addAll(List.generate(widget.examQuestions.length, (index) => 0));
//     // lineValue.addAll(List.generate(widget.examQuestions.length, (index) => -1));
//     widget.showQuestionButton
//         ? questionNumberState
//             .addAll(List.generate(widget.examQuestions.length, (index) => -1))
//         : null;
//     widget.hasTime ? endExamTime = widget.endTime! : null;
//     saveChanged();
//     print(radioValue);
//   }

//   Color getColor(int questionIndex) {
//     if (questionNumberState[questionIndex] == 1) {
//       return Colors.green;
//     } else if (questionNumberState[questionIndex] == 0) {
//       return Colors.red;
//     } else {
//       return Colors.white;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF000518),
//       appBar: AppBar(
//         backgroundColor: Colors.white.withOpacity(.05),
//         title: Text(
//           widget.appBarTitle,
//           style: const TextStyle(
//               color: Color(0xFF62FCD7),
//               fontSize: 22,
//               fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white.withOpacity(.05),
//               ),
//               onPressed: () {
//                 try {
//                   int score = calculateScore(
//                       userAnswers: radioValue,
//                       rightAnswers: widget.rightAnswers);

//                   updateExamData(
//                     collectionName: widget.collectionName,
//                     subDocId: subDocId,
//                     data: widget.showQuestionButton
//                         ? {
//                             "answer": radioValue,
//                             "questionNumberState": questionNumberState,
//                             "score": score,
//                             "endTime": DateTime.now(),
//                             "isFinished": true,
//                           }
//                         : {
//                             "answer": radioValue,
//                             // "questionNumberState": questionNumberState,
//                             "score": score,
//                             "endTime": DateTime.now(),
//                             "isFinished": true,
//                           },
//                   );
//                 } catch (e) {
//                   print(e);
//                 }
//                 updateUserData(percent: widget.precent);
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ScoreScreen(
//                               userAnswers: radioValue,
//                               rightAnswers: widget.rightAnswers,
//                             )));
//               },
//               child: const Text(
//                 AppString.finshExam,
//                 style: TextStyle(
//                     color: Color(0xFF62FCD7),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Row(
//         children: [
//           widget.showQuestionButton
//               ? Container(
//                   width: 50,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                   color: Colors.white.withOpacity(.05),
//                   child: ListView.builder(
//                     itemCount: widget.examQuestions.length,
//                     itemBuilder: (context, questionIndex) {
//                       return QuestionNumberButton(
//                         number: questionIndex + 1,
//                         color: getColor(questionIndex),
//                         onPressed: () {
//                           setState(() {
//                             radioValue[index] == 0
//                                 ? questionNumberState[index] = 0
//                                 : null;
//                             index = questionIndex;
//                           });
//                           // updateExamData(
//                           //   collectionName: widget.collectionName,
//                           //   subDocId: subDocId,
//                           //   data: {
//                           //     "answer": radioValue,
//                           //     "questionNumberState": questionNumberState,
//                           //     "score": 0,
//                           //   },
//                           // );
//                         },
//                       );
//                     },
//                   ),
//                 )
//               : const SizedBox(),
//           Expanded(
//             child: CustomScrollView(
//               slivers: [
//                 SliverFillRemaining(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 20),
//                       widget.hasTime
//                           ? TimerCountdown(
//                               hoursDescription: "ساعة",
//                               minutesDescription: "دقيقة",
//                               secondsDescription: "ثانية",
//                               format: CountDownTimerFormat.hoursMinutesSeconds,
//                               endTime: endExamTime,
//                               onTick: (remainingTime) {
//                                 if (remainingTime.inMinutes == 5) {
//                                   // showDialog(context: context, builder: builder);
//                                 }
//                                 // print("Remaining Time: $remainingTime");
//                               },
//                               onEnd: () {
//                                 try {
//                                   int score = calculateScore(
//                                       userAnswers: radioValue,
//                                       rightAnswers: widget.rightAnswers);

//                                   updateExamData(
//                                     collectionName: widget.collectionName,
//                                     subDocId: subDocId,
//                                     data: widget.showQuestionButton
//                                         ? {
//                                             "answer": radioValue,
//                                             "questionNumberState":
//                                                 questionNumberState,
//                                             "score": score,
//                                             "endTime": DateTime.now(),
//                                             "isFinished": true,
//                                           }
//                                         : {
//                                             "answer": radioValue,
//                                             // "questionNumberState":
//                                             //     questionNumberState,
//                                             "score": score,
//                                             "endTime": DateTime.now(),
//                                             "isFinished": true,
//                                           },
//                                   );
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                   backgroundColor: Colors.red,
//                                   content: Center(
//                                     child: Text("انتهى الوقت تم حفظ الاجابات",
//                                         style: TextStyle(
//                                             fontSize: 20, color: Colors.white)),
//                                   ),
//                                   duration: Duration(seconds: 2),
//                                 ));
//                                 updateUserData(percent: widget.precent);
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => ScoreScreen(
//                                               userAnswers: radioValue,
//                                               rightAnswers: widget.rightAnswers,
//                                             )));

//                                 print("Timer finished");
//                               },
//                             )
//                           : const SizedBox(),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             QuestionsUi(
//                               examQuestions: widget.examQuestions[index],
//                               index: index,
//                               radioValue: radioValue[index],
//                               isAnswered: false,
//                               rightAnswer: widget.rightAnswers[index],
//                               onChanged: isShowAnswer
//                                   ? (value) {}
//                                   : (value) {
//                                       setState(() {
//                                         radioValue[index] = value!;
//                                         // widget.showQuestionButton
//                                         //     ? questionNumberState[index] = 1
//                                         //     : null;
//                                       });
//                                     },
//                             ),
//                             widget.showQuestionButton
//                                 ? const SizedBox()
//                                 : isShowAnswer
//                                     ? Column(
//                                         children: [
//                                           const Padding(
//                                             padding: EdgeInsets.only(right: 10),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: Text(
//                                                 "الاجابة الصحيحة",
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Color(0xFF62FCD7),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   margin: const EdgeInsets.only(
//                                                       left: 10,
//                                                       right: 10,
//                                                       bottom: 20),
//                                                   padding:
//                                                       const EdgeInsets.all(20),
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     color: Color(0xFFf07167),
//                                                     borderRadius:
//                                                         BorderRadius.only(
//                                                       topRight:
//                                                           Radius.circular(0),
//                                                       topLeft:
//                                                           Radius.circular(10),
//                                                       bottomRight:
//                                                           Radius.circular(10),
//                                                       bottomLeft:
//                                                           Radius.circular(10),
//                                                     ),
//                                                   ),
//                                                   child: Align(
//                                                     alignment:
//                                                         Alignment.topRight,
//                                                     child: Text(
//                                                       radioValue[index] ==
//                                                               widget.rightAnswers[
//                                                                   index]
//                                                           ? widget.examQuestions[
//                                                               index]["T"]
//                                                           : widget.examQuestions[
//                                                               index]["F"],
//                                                       style: const TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color:
//                                                             AppColor.textColor1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       )
//                                     : const SizedBox(),
//                             //  widget.examQuestions[index]["T"]
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 widget.showQuestionButton
//                                     ? const SizedBox()
//                                     : ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8)),
//                                           backgroundColor:
//                                               const Color(0xFF62FCD7),
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 20, vertical: 10),
//                                         ),
//                                         onPressed: () {
//                                           setState(() {
//                                             isShowAnswer = false;
//                                             index ==
//                                                     widget.examQuestions
//                                                             .length -
//                                                         1
//                                                 ? null
//                                                 : index++;
//                                             updateExamData(
//                                               collectionName:
//                                                   widget.collectionName,
//                                               subDocId: subDocId,
//                                               data: {
//                                                 "questionIndex": index,
//                                               },
//                                             );
//                                           });
//                                         },
//                                         child: const Text(
//                                           "التالي",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16),
//                                         ),
//                                       ),
//                                 const SizedBox(width: 15),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8)),
//                                     backgroundColor: const Color(0xFF62FCD7),
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 10),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       widget.showQuestionButton
//                                           ? null
//                                           : isShowAnswer = true;
//                                       widget.showQuestionButton
//                                           ? radioValue[index] == 0
//                                               ? questionNumberState[index] = 0
//                                               : questionNumberState[index] = 1
//                                           : null;

//                                       // radioValue.add(0);
//                                       // index == widget.examQuestions.length - 1
//                                       //     ? null
//                                       //     : index++;
//                                     });
//                                     updateExamData(
//                                       collectionName: widget.collectionName,
//                                       subDocId: subDocId,
//                                       data: widget.showQuestionButton
//                                           ? {
//                                               "answer": radioValue,
//                                               "questionNumberState":
//                                                   questionNumberState,
//                                               "score": 0,
//                                             }
//                                           : {
//                                               "answer": radioValue,
//                                               // "questionNumberState": questionNumberState,
//                                               "score": 0,
//                                             },
//                                     );
//                                   },
//                                   child: const Text(
//                                     "حفظ",
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 16),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             // Padding(
//                             //   padding:
//                             //       const EdgeInsets.symmetric(horizontal: 20),
//                             //   child: Row(
//                             //     mainAxisAlignment:
//                             //         MainAxisAlignment.spaceBetween,
//                             //     children: [
//                             //       CustomButtonNextBackScreen(
//                             //         icon: Icons.arrow_back_ios_new,
//                             //         color:
//                             //             index == widget.examQuestions.length - 1
//                             //                 ? Colors.grey
//                             //                 : const Color(0xFF62FCD7),
//                             //         onPressed: index ==
//                             //                 widget.examQuestions.length - 1
//                             //             ? null
//                             //             : () {
//                             //                 setState(() {
//                             //                   radioValue[index] == 0
//                             //                       ? questionNumberState[index] =
//                             //                           0
//                             //                       : null;
//                             //                   // radioValue.add(0);
//                             //                   index++;
//                             //                 });
//                             //                 updateExamData(
//                             //                   collectionName:
//                             //                       widget.collectionName,
//                             //                   subDocId: subDocId,
//                             //                   data: {
//                             //                     "answer": radioValue,
//                             //                     "questionNumberState":
//                             //                         questionNumberState,
//                             //                     "score": 0,
//                             //                   },
//                             //                 );
//                             //               },
//                             //       ),
//                             //       Text(
//                             //         "${index + 1}",
//                             //         style: const TextStyle(
//                             //             color: Color(0xFF62FCD7),
//                             //             fontSize: 20,
//                             //             fontWeight: FontWeight.bold),
//                             //       ),
//                             //       CustomButtonNextBackScreen(
//                             //         icon: Icons.arrow_forward_ios,
//                             //         color: index == 0
//                             //             ? Colors.grey
//                             //             : const Color(0xFF62FCD7),
//                             //         onPressed: index <= 0
//                             //             ? null
//                             //             : () {
//                             //                 setState(() {
//                             //                   radioValue[index] == 0
//                             //                       ? questionNumberState[index] =
//                             //                           0
//                             //                       : null;
//                             //                   index--;
//                             //                 });
//                             //                 updateExamData(
//                             //                   collectionName:
//                             //                       widget.collectionName,
//                             //                   subDocId: subDocId,
//                             //                   data: {
//                             //                     "answer": radioValue,
//                             //                     "questionNumberState":
//                             //                         questionNumberState,
//                             //                     "score": 0,
//                             //                   },
//                             //                 );
//                             //               },
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// //   double linePercentValue() {
// //     if (radioValue[index] != 0 && !lineValue.contains(index)) {
// //       lineValue.add(index);
// //       if (solve < widget.examQuestions.length) {
// //         return ++solve / widget.examQuestions.length;
// //       } else {
// //         return 1;
// //       }
// //     } else {
// //       return solve / widget.examQuestions.length;
// //     }
// //   }
// }

// class QuestionNumberButton extends StatelessWidget {
//   const QuestionNumberButton({
//     super.key,
//     required this.number,
//     this.onPressed,
//     required this.color,
//   });
//   final int number;
//   final Color color;
//   final void Function()? onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: SizedBox(
//         height: 40,
//         width: 40,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ButtonStyle(
//             overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
//             padding: const MaterialStatePropertyAll(EdgeInsets.zero),
//             backgroundColor: MaterialStatePropertyAll(color),
//           ),
//           child: Center(
//             child: Text(
//               number.toString(),
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
