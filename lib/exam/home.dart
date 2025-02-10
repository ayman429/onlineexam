// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../core/constant/app_color.dart';
import '../core/constant/app_string.dart';
import '../core/firebase/firebase_get_doc_percent.dart';
import '../core/firebase/firebase_get_user_answer.dart';
import 'functions/loading_dialog.dart';
import 'functions/show_dialog_finish.dart';
import 'functions/show_dialog_index_exam.dart';
import 'widgets/0_pre_exam.dart';
import 'widgets/3_third_exam.dart';
import 'widgets/4_fourth_exam.dart';
import 'widgets/5_fifth_exam.dart';
import 'widgets/6_post_exam.dart';
import 'widgets/drawer_widget.dart';
import 'widgets/1_first_exam.dart';
import 'widgets/2_second_exam.dart';
import 'widgets/tips_exam.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.precent});
  final int precent;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int widget.precent = 0;

  onTapExamNameWidget(
      {required BuildContext context,
      required bool showQuestionButton,
      required String collectionName,
      required int value,
      required String tipsExamAppBarTitle,
      required String pdf}) async {
    Map<String, dynamic> userAnswers = {};
    Map<String, dynamic> userAnswersPreExam = {};
    loadingDialog(context);
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    if (isConnected) {
      userAnswers = await getUserAnswer(
          docUserId: "",
          showQuestionButton: showQuestionButton,
          collectionName: collectionName);
      userAnswersPreExam = await getUserAnswer(
          docUserId: "",
          showQuestionButton: true,
          collectionName: AppString.preExamCollection);

      // int widget.precent = await getDocPercent();
      Navigator.pop(context);
      // if (isConnected) {
      bool isFinished = userAnswers["isFinished"] ?? false;
      double examLength = 0;
      switch (value) {
        case 1:
          examLength = (userAnswersPreExam["userAnswersData"]["exam1Score"] /
                  AppString.exam1Length) *
              100;
          break;
        case 2:
          examLength = (userAnswersPreExam["userAnswersData"]["exam2Score"] /
                  AppString.exam2Length) *
              100;
          break;
        case 3:
          examLength = (userAnswersPreExam["userAnswersData"]["exam3Score"] /
                  AppString.exam3Length) *
              100;
          break;
        case 4:
          examLength = (userAnswersPreExam["userAnswersData"]["exam4Score"] /
                  AppString.exam4Length) *
              100;
          break;
        case 5:
          examLength = (userAnswersPreExam["userAnswersData"]["exam5Score"] /
                  AppString.exam5Length) *
              100;
          break;
        default:
          examLength = 0;
          break;
      }

      userAnswers.entries.isEmpty
          ?
          // widget.precent == value
          //     ?
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TipsExam(
                    examLength: examLength,
                    pdf: pdf,
                    value: value,
                    tipsExamAppBarTitle: tipsExamAppBarTitle),
              ),
            )
          // : showDialogIndexExam(context)
          : isFinished
              ? showDialogFinish(context)
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    switch (value) {
                      case 0:
                        return PreExam(userAnswers: userAnswers);

                      case 1:
                        return FirstExam(
                            examLength: examLength, userAnswers: userAnswers);

                      case 2:
                        return SecondExam(
                            examLength: examLength, userAnswers: userAnswers);

                      case 3:
                        return ThirdExam(
                            examLength: examLength, userAnswers: userAnswers);

                      case 4:
                        return FourthExam(
                            examLength: examLength, userAnswers: userAnswers);

                      case 5:
                        return FifthExam(
                            examLength: examLength, userAnswers: userAnswers);

                      case 6:
                        return PostExam(userAnswers: userAnswers);

                      default:
                        return PreExam(userAnswers: userAnswers);
                    }
                  }),
                );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Center(
          child: Text("لا يوجد اتصال بالإنترنت",
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  // getPercent() async {
  //   widget.precent = await getDocPercent();
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     getPercent();
  //   });
  //   // getPercent();
  //   // print("==================");
  // }

  @override
  Widget build(BuildContext context) {
    print('precent: ${widget.precent}');
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColor.backgroundColor1,
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor3,
          surfaceTintColor: AppColor.backgroundColor3,
          shadowColor: const Color(0xFFc9d3de),
          elevation: 4,
          // automaticallyImplyLeading: false,
          title: Text(
            AppString.examsAppBarTitle,
            style: TextStyle(
                color: AppColor.textColor1,
                fontSize: MediaQuery.sizeOf(context).width * 0.06,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: AppColor.iconColor1,
            ),
          ),
        ),
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: List.generate(4, (index) {
                  return Container(
                    width: double.infinity,
                    // height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/img${index + 2}.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: false,
                examName: AppString.preExamTitle,
                onTap: () {
                  return onTapExamNameWidget(
                    pdf: "assets/pdf/pre_exam.pdf",
                    context: context,
                    collectionName: AppString.preExamCollection,
                    value: 0,
                    showQuestionButton: true,
                    tipsExamAppBarTitle: AppString.preExamTitle,
                  );
                },
              ),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: widget.precent == 0 ? true : false,
                examName: AppString.exam1Title,
                onTap: widget.precent == 0
                    ? null
                    : () {
                        return onTapExamNameWidget(
                          pdf: "assets/pdf/exam1.pdf",
                          context: context,
                          collectionName: AppString.firstExamCollection,
                          value: 1,
                          showQuestionButton: false,
                          tipsExamAppBarTitle: AppString.exam1Title,
                        );
                      },
              ),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: widget.precent == 0 ? true : false,
                examName: AppString.exam2Title,
                onTap: widget.precent == 0
                    ? null
                    : () {
                        return onTapExamNameWidget(
                          pdf: "assets/pdf/exam2.pdf",
                          context: context,
                          collectionName: AppString.secondExamCollection,
                          value: 2,
                          showQuestionButton: false,
                          tipsExamAppBarTitle: AppString.exam2Title,
                        );
                      },
              ),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: widget.precent == 0 ? true : false,
                examName: AppString.exam3Title,
                onTap: widget.precent == 0
                    ? null
                    : () {
                        return onTapExamNameWidget(
                          pdf: "assets/pdf/exam3.pdf",
                          context: context,
                          collectionName: AppString.thirdExamCollection,
                          value: 3,
                          showQuestionButton: false,
                          tipsExamAppBarTitle: AppString.exam3Title,
                        );
                      },
              ),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: widget.precent == 0 ? true : false,
                examName: AppString.exam4Title,
                onTap: widget.precent == 0
                    ? null
                    : () {
                        return onTapExamNameWidget(
                          pdf: "assets/pdf/exam4.pdf",
                          context: context,
                          collectionName: AppString.fourthExamCollection,
                          value: 4,
                          showQuestionButton: false,
                          tipsExamAppBarTitle: AppString.exam4Title,
                        );
                      },
              ),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: widget.precent == 0 ? true : false,
                examName: AppString.exam5Title,
                onTap: widget.precent == 0
                    ? null
                    : () {
                        return onTapExamNameWidget(
                          pdf: "assets/pdf/exam5.pdf",
                          context: context,
                          collectionName: AppString.fifthExamCollection,
                          value: 5,
                          showQuestionButton: false,
                          tipsExamAppBarTitle: AppString.exam5Title,
                        );
                      },
              ),
              ExamNameWidget(
                icon: Icons.play_circle_outline,
                showLock: widget.precent < 6 ? true : false,
                examName: AppString.postExamTitle,
                onTap: widget.precent < 6
                    ? null
                    : () {
                        return onTapExamNameWidget(
                          pdf: "assets/pdf/post_exam.pdf",
                          context: context,
                          collectionName: AppString.postExamCollection,
                          value: 6,
                          showQuestionButton: true,
                          tipsExamAppBarTitle: AppString.postExamTitle,
                        );
                      },
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  LinearPercentIndicator(
                    isRTL: true,
                    lineHeight: 14.0,
                    percent: widget.precent / 7,
                    barRadius: const Radius.circular(20),
                    backgroundColor: AppColor.backgroundColor2,
                    progressColor: AppColor.primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        const Text(
                          "نسبة التقدم:",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.textColor1,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "%${(widget.precent / 7 * 100).round()}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColor.textColor3, //Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // CircularPercentIndicator(
              //   radius: 30,
              //   lineWidth: 10,
              //   percent: 0.5,
              //   progressColor: const Color(0xFF62FCD7),
              //   backgroundColor: Colors.white,
              //   center: const Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "50%",
              //         style: TextStyle(fontSize: 12, color: Colors.white),
              //       ),
              //       // Text(
              //       //   "100",
              //       //   style: TextStyle(color: Colors.white, fontSize: 20),
              //       // ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const FirstExam()));
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.all(20),
              //     width: double.infinity,
              //     height: 200,
              //     decoration: BoxDecoration(
              //       color: Colors.white.withOpacity(.05),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Center(
              //         child: Text(AppString.firstExamAppBarTitle,
              //             style: TextStyle(
              //                 color: Color(0xFF62FCD7),
              //                 fontSize: 22,
              //                 fontWeight: FontWeight.bold))),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const SecondExam()));
              //   },
              //   child: Container(
              //     margin:
              //         const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              //     width: double.infinity,
              //     height: 200,
              //     decoration: BoxDecoration(
              //       color: Colors.white.withOpacity(.05),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Center(
              //         child: Text(AppString.secondExamAppBarTitle,
              //             style: TextStyle(
              //                 color: Color(0xFF62FCD7),
              //                 fontSize: 22,
              //                 fontWeight: FontWeight.bold))),
              //   ),
              // ),
            ],
          ),
        ));
  }
}

class ExamNameWidget extends StatelessWidget {
  const ExamNameWidget({
    super.key,
    required this.examName,
    this.onTap,
    required this.icon,
    required this.showLock,
  });
  final String examName;
  final Function()? onTap;
  final IconData icon;
  // final int widget.precent;
  // final int num;
  final bool showLock;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: showLock ? Colors.grey : AppColor.iconColor2,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    examName,
                    style: TextStyle(
                        color: showLock
                            ? Colors.grey
                            : AppColor.textColor1, //AppColor.primaryColor,
                        fontSize: 20),
                  ),
                ),
                showLock
                    ? const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.lock,
                          color: Color(0xFFffa509), //AppColor.textColor3,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            thickness: 5,
            color: AppColor.backgroundColor3,
          ),
        ),
      ],
    );
  }
}
