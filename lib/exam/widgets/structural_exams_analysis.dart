import 'package:flutter/material.dart';
import 'package:onlineexam/core/exams/0_pre_exam.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_string.dart';
import '../../core/exams/6_post_exam.dart';
import '../functions/calculate_HME_percentage.dart';
import 'chart2.dart';
import 'custom_text_container.dart';
import 'divider_widget.dart';

class StructuralExamsAnalysis extends StatelessWidget {
  const StructuralExamsAnalysis({
    super.key,
    required this.userAnswersPreExamAnalysis,
    // required this.title,
    required this.userAnswersPostExamAnalysis,
    required this.userAnswersExam1Analysis,
    required this.userAnswersExam2Analysis,
    required this.userAnswersExam3Analysis,
    required this.userAnswersExam4Analysis,
    required this.userAnswersExam5Analysis,
  });

  final Map<String, dynamic> userAnswersPreExamAnalysis;
  final Map<String, dynamic> userAnswersPostExamAnalysis;
  final Map<String, dynamic> userAnswersExam1Analysis,
      userAnswersExam2Analysis,
      userAnswersExam3Analysis,
      userAnswersExam4Analysis,
      userAnswersExam5Analysis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor3,
        surfaceTintColor: AppColor.backgroundColor3,
        shadowColor: const Color(0xFFc9d3de),
        elevation: 4,
        title: const Text(
          AppString.structuralExams,
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.textColor3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noData(context),
              const SizedBox(height: 20),
              userAnswersExam1Analysis.isNotEmpty
                  ? userAnswersExam1Analysis["isFinished"]
                      ? Column(
                          children: [
                            UserAnswersExamAnalysis(
                              examLength: AppString.exam1Length,
                              preSubExamNumberSol:
                                  userAnswersPreExamAnalysis["exam1Score"],
                              postSubExamNumberSol: userAnswersPostExamAnalysis
                                      .isNotEmpty
                                  ? userAnswersPostExamAnalysis["exam1Score"]
                                  : -1,
                              userAnswersExamAnalysis: userAnswersExam1Analysis,
                              title: AppString.exam1Title,
                            ),
                            DividerWidget(hasChange: true),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              userAnswersExam2Analysis.isNotEmpty
                  ? userAnswersExam2Analysis["isFinished"]
                      ? Column(
                          children: [
                            UserAnswersExamAnalysis(
                              examLength: AppString.exam2Length,
                              preSubExamNumberSol:
                                  userAnswersPreExamAnalysis["exam2Score"],
                              postSubExamNumberSol: userAnswersPostExamAnalysis
                                      .isNotEmpty
                                  ? userAnswersPostExamAnalysis["exam2Score"]
                                  : -1,
                              userAnswersExamAnalysis: userAnswersExam2Analysis,
                              title: AppString.exam2Title,
                            ),
                            DividerWidget(hasChange: true),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              userAnswersExam3Analysis.isNotEmpty
                  ? userAnswersExam3Analysis["isFinished"]
                      ? Column(
                          children: [
                            UserAnswersExamAnalysis(
                              examLength: AppString.exam3Length,
                              preSubExamNumberSol:
                                  userAnswersPreExamAnalysis["exam3Score"],
                              postSubExamNumberSol: userAnswersPostExamAnalysis
                                      .isNotEmpty
                                  ? userAnswersPostExamAnalysis["exam3Score"]
                                  : -1,
                              userAnswersExamAnalysis: userAnswersExam3Analysis,
                              title: AppString.exam3Title,
                            ),
                            DividerWidget(hasChange: true),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              userAnswersExam4Analysis.isNotEmpty
                  ? userAnswersExam4Analysis["isFinished"]
                      ? Column(
                          children: [
                            UserAnswersExamAnalysis(
                              examLength: AppString.exam4Length,
                              preSubExamNumberSol:
                                  userAnswersPreExamAnalysis["exam4Score"],
                              postSubExamNumberSol: userAnswersPostExamAnalysis
                                      .isNotEmpty
                                  ? userAnswersPostExamAnalysis["exam4Score"]
                                  : -1,
                              userAnswersExamAnalysis: userAnswersExam4Analysis,
                              title: AppString.exam4Title,
                            ),
                            DividerWidget(hasChange: true),
                            const SizedBox(height: 20),
                          ],
                        )
                      : const SizedBox()
                  : const SizedBox(),
              userAnswersExam5Analysis.isNotEmpty
                  ? userAnswersExam5Analysis["isFinished"]
                      ? UserAnswersExamAnalysis(
                          examLength: AppString.exam5Length,
                          preSubExamNumberSol:
                              userAnswersPreExamAnalysis["exam5Score"],
                          postSubExamNumberSol:
                              userAnswersPostExamAnalysis.isNotEmpty
                                  ? userAnswersPostExamAnalysis["exam5Score"]
                                  : -1,
                          userAnswersExamAnalysis: userAnswersExam5Analysis,
                          title: AppString.exam5Title,
                        )
                      : const SizedBox()
                  : const SizedBox(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget noData(context) {
    if (userAnswersExam1Analysis.isNotEmpty ||
        userAnswersExam2Analysis.isNotEmpty ||
        userAnswersExam3Analysis.isNotEmpty ||
        userAnswersExam4Analysis.isNotEmpty ||
        userAnswersExam5Analysis.isNotEmpty) {
      if ((userAnswersExam1Analysis.isNotEmpty
              ? userAnswersExam1Analysis["isFinished"] == false
              : true) &&
          (userAnswersExam2Analysis.isNotEmpty
              ? userAnswersExam2Analysis["isFinished"] == false
              : true) &&
          (userAnswersExam3Analysis.isNotEmpty
              ? userAnswersExam3Analysis["isFinished"] == false
              : true) &&
          (userAnswersExam4Analysis.isNotEmpty
              ? userAnswersExam4Analysis["isFinished"] == false
              : true) &&
          (userAnswersExam5Analysis.isNotEmpty
              ? userAnswersExam5Analysis["isFinished"] == false
              : true)) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height / 2 - 120),
            child: Text(
              "لم يتم الإجابة على الأسئلة بعد",
              style: TextStyle(
                  color: AppColor.textColor3,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        return SizedBox();
      }
    } else {
      return Center(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 2 - 120),
          child: Text(
            "لم يتم الإجابة على الأسئلة بعد",
            style: TextStyle(
                color: AppColor.textColor3,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}

class UserAnswersExamAnalysis extends StatelessWidget {
  final Map<String, dynamic> userAnswersExamAnalysis;
  final int preSubExamNumberSol;
  final int postSubExamNumberSol;
  final String title; //AppString.exam1Title,
  final int examLength;

  const UserAnswersExamAnalysis({
    super.key,
    required this.userAnswersExamAnalysis,
    required this.title,
    required this.preSubExamNumberSol,
    required this.postSubExamNumberSol,
    required this.examLength,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
              color: AppColor.textColor3,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        PieChartSample2(
          color: [
            AppColorsChart.contentColorBlue,
            AppColorsChart.contentColorYellow,
            AppColorsChart.contentColorPurple,
            // AppColorsChart.contentColorGreen,
            AppColorsChart.contentColorOrange,
            AppColorsChart.pageBackground,
          ],
          length: 5,
          isColumn: false,
          text: [
            "سهل",
            "متوسط",
            "صعب",
            "اجابة خاطئة",
            "لم يتم الإجابة",
          ],
          values: [
            calculateHMEpercentage(userAnswersExamAnalysis)["easy"].toDouble(),
            calculateHMEpercentage(userAnswersExamAnalysis)["medium"]
                .toDouble(),
            calculateHMEpercentage(userAnswersExamAnalysis)["hard"].toDouble(),
            calculateHMEpercentage(userAnswersExamAnalysis)["wrong"].toDouble(),
            calculateHMEpercentage(userAnswersExamAnalysis)["notAnswered"]
                .toDouble(),
          ],
        ),
        const SizedBox(height: 20),
        // -------------------
        postSubExamNumberSol != -1
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "نسبة التحسن/التراجع",
                    style: const TextStyle(
                        color: AppColor.textColor3,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              )
            : SizedBox(),
        postSubExamNumberSol != -1
            ? Container(
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
                child: Column(
                  children: [
                    //----------------------

                    CircularPercentIndicator(
                      radius: 70,
                      lineWidth: 15,
                      percent: ((postSubExamNumberSol / examLength) -
                              (preSubExamNumberSol / examLength))
                          .toDouble()
                          .abs(),
                      progressColor: (((postSubExamNumberSol / examLength) -
                                          (preSubExamNumberSol / examLength)) *
                                      100)
                                  .round() >
                              0
                          ? AppColor.contentColorGreen
                          : AppColor.contentColorRed,
                      backgroundColor: (((postSubExamNumberSol / examLength) -
                                          (preSubExamNumberSol / examLength)) *
                                      100)
                                  .round() ==
                              0
                          ? AppColor.textColor1
                          : Colors.white,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${(((((postSubExamNumberSol / examLength) * 100).round() - ((preSubExamNumberSol / examLength) * 100).round()))).abs()}%",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textColor1),
                          ),
                        ],
                      ),
                    ),

                    //----------------------
                    SizedBox(height: 10),
                    CustomTextContainer(
                      title: "(${AppString.preExamTitle}) " + title,
                      value:
                          "${((preSubExamNumberSol / examLength) * 100).round()}%",
                    ),
                    DividerWidget(),
                    CustomTextContainer(
                      title: title,
                      value:
                          "${calculateHMEpercentage(userAnswersExamAnalysis)["examPercentage"]}%",
                    ),
                    DividerWidget(),
                    CustomTextContainer(
                      title: "(${AppString.postExamTitle}) " + title,
                      value:
                          "${((postSubExamNumberSol / examLength) * 100).round()}%",
                    ),
                    // DividerWidget(),
                  ],
                ),
              )
            : const SizedBox(),

        postSubExamNumberSol != -1
            ? const SizedBox(height: 20)
            : const SizedBox(),
      ],
    );
  }
}
