import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../Auth/components/custom_button_auth.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_string.dart';
import '../../core/exams/0_pre_exam.dart';
import '../../core/firebase/firebase_get_user_answer.dart';
import 'chart1.dart';
import 'chart2.dart';
import 'custom_text_container.dart';
import 'indicator.dart';
import 'leader_board.dart';
import 'structural_exams_analysis.dart';

class UserAnalysis extends StatefulWidget {
  const UserAnalysis(
      {super.key,
      required this.userAnswersPreExamAnalysis,
      required this.userAnswersPostExamAnalysis,
      required this.docUserId});
  final Map<String, dynamic> userAnswersPreExamAnalysis;
  final Map<String, dynamic> userAnswersPostExamAnalysis;
  final String docUserId;

  @override
  State<UserAnalysis> createState() => _UserAnalysisState();
}

class _UserAnalysisState extends State<UserAnalysis> {
  bool isloading = false;
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
          "تحليلات",
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
            children: [
              widget.userAnswersPreExamAnalysis.entries.isNotEmpty &&
                      widget.userAnswersPostExamAnalysis.entries.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "نسبة التحسن/التراجع",
                          style: const TextStyle(
                              color: AppColor.textColor3,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          // margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 10),
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
                              CircularPercentIndicator(
                                radius: 70,
                                lineWidth: 15,
                                percent: ((((widget.userAnswersPostExamAnalysis[
                                                            "totalScore"] /
                                                        AppString
                                                            .examTotalDegree) *
                                                    100)
                                                .round() -
                                            ((widget.userAnswersPreExamAnalysis[
                                                            "totalScore"] /
                                                        AppString
                                                            .examTotalDegree) *
                                                    100)
                                                .round()) /
                                        100)
                                    .abs(),
                                progressColor: getProgressColor(),
                                backgroundColor: ((((widget.userAnswersPostExamAnalysis[
                                                                "totalScore"] /
                                                            AppString
                                                                .examTotalDegree) *
                                                        100)
                                                    .round() -
                                                ((widget.userAnswersPreExamAnalysis[
                                                                "totalScore"] /
                                                            AppString
                                                                .examTotalDegree) *
                                                        100)
                                                    .round()))
                                            .abs() ==
                                        0
                                    ? AppColor.textColor1
                                    : Colors.white,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${((((widget.userAnswersPostExamAnalysis["totalScore"] / AppString.examTotalDegree) * 100).round() - ((widget.userAnswersPreExamAnalysis["totalScore"] / AppString.examTotalDegree) * 100).round())).abs()}%",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.textColor1),
                                    ),
                                    // Text(
                                    //   "100",
                                    //   style: TextStyle(color: Colors.white, fontSize: 20),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextContainer(
                                  title: AppString.preExamTitle,
                                  value: widget.userAnswersPreExamAnalysis[
                                              "totalScore"]
                                          .toString() +
                                      "/${AppString.examTotalDegree}"
                                  // "${((widget.userAnswersPreExamAnalysis["totalScore"] / AppString.examTotalDegree) * 100).round()}/880",
                                  ),
                              DividerWidget(),
                              CustomTextContainer(
                                title: AppString.postExamTitle,
                                value: widget.userAnswersPostExamAnalysis[
                                            "totalScore"]
                                        .toString() +
                                    "/${AppString.examTotalDegree}",
                                //"${((widget.userAnswersPostExamAnalysis["totalScore"] / AppString.examTotalDegree) * 100).round()}/880",
                              ),
                              DividerWidget(),
                              IndicatorWidget(
                                color: AppColor.contentColorGreen,
                                text: "تحسن المستوي",
                                isSquare: true,
                              ),
                              IndicatorWidget(
                                color: AppColor.contentColorRed,
                                text: "تراجع المستوي",
                                isSquare: true,
                              ),
                              IndicatorWidget(
                                color: AppColor.textColor1,
                                text: "ثبوت المستوي",
                                isSquare: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : SizedBox(),
              widget.userAnswersPreExamAnalysis.entries.isEmpty
                  ? Center(
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
                    )
                  : PrePostExamAnalysis(
                      title: AppString.preExamTitle,
                      userAnswersPrePostExamAnalysis:
                          widget.userAnswersPreExamAnalysis),
              widget.userAnswersPostExamAnalysis.entries.isEmpty
                  ? const SizedBox()
                  : PrePostExamAnalysis(
                      title: AppString.postExamTitle,
                      userAnswersPrePostExamAnalysis:
                          widget.userAnswersPostExamAnalysis),
              // const Chart1(),
              const SizedBox(height: 20),
              widget.userAnswersPreExamAnalysis.entries.isNotEmpty
                  ? CustomButtonAuth(
                      isloading: isloading,
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        Map<String, dynamic> userAnswersExam1Analysis = {},
                            userAnswersExam2Analysis = {},
                            userAnswersExam3Analysis = {},
                            userAnswersExam4Analysis = {},
                            userAnswersExam5Analysis = {};
                        userAnswersExam1Analysis = await getUserAnswer(
                            docUserId: widget.docUserId,
                            collectionName: AppString.firstExamCollection,
                            showQuestionButton: false);
                        userAnswersExam2Analysis = await getUserAnswer(
                            docUserId: widget.docUserId,
                            collectionName: AppString.secondExamCollection,
                            showQuestionButton: false);
                        userAnswersExam3Analysis = await getUserAnswer(
                            docUserId: widget.docUserId,
                            collectionName: AppString.thirdExamCollection,
                            showQuestionButton: false);
                        userAnswersExam4Analysis = await getUserAnswer(
                            docUserId: widget.docUserId,
                            collectionName: AppString.fourthExamCollection,
                            showQuestionButton: false);
                        userAnswersExam5Analysis = await getUserAnswer(
                            docUserId: widget.docUserId,
                            collectionName: AppString.fifthExamCollection,
                            showQuestionButton: false);

                        setState(() {
                          isloading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StructuralExamsAnalysis(
                                userAnswersExam1Analysis:
                                    userAnswersExam1Analysis,
                                userAnswersExam2Analysis:
                                    userAnswersExam2Analysis,
                                userAnswersExam3Analysis:
                                    userAnswersExam3Analysis,
                                userAnswersExam4Analysis:
                                    userAnswersExam4Analysis,
                                userAnswersExam5Analysis:
                                    userAnswersExam5Analysis,
                                userAnswersPreExamAnalysis:
                                    widget.userAnswersPreExamAnalysis,
                                // title: AppString.structuralExams,
                                userAnswersPostExamAnalysis:
                                    widget.userAnswersPostExamAnalysis),
                          ),
                        );
                      },
                      text: AppString.structuralExams,
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Color getProgressColor() {
    Color? progressColor;
    ((((widget.userAnswersPostExamAnalysis["totalScore"] /
                            AppString.examTotalDegree) *
                        100)
                    .round() -
                ((widget.userAnswersPreExamAnalysis["totalScore"] /
                            AppString.examTotalDegree) *
                        100)
                    .round())) ==
            0
        ? progressColor = AppColor.textColor1
        : ((((widget.userAnswersPostExamAnalysis["totalScore"] /
                                AppString.examTotalDegree) *
                            100)
                        .round() -
                    ((widget.userAnswersPreExamAnalysis["totalScore"] /
                                AppString.examTotalDegree) *
                            100)
                        .round())) >
                0
            ? progressColor = AppColor.contentColorGreen
            : progressColor = AppColor.contentColorRed;
    return progressColor;
  }
}

class PrePostExamAnalysis extends StatelessWidget {
  const PrePostExamAnalysis({
    super.key,
    required this.userAnswersPrePostExamAnalysis,
    required this.title,
  });

  final Map<String, dynamic> userAnswersPrePostExamAnalysis;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
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
            AppColorsChart.contentColorGreen,
            AppColorsChart.contentColorOrange,
            AppColorsChart.pageBackground,
          ],
          length: 6,
          isColumn: false,
          text: [
            "${AppString.remember} %${((AppString.rememberLength / preExamQuestions.length) * 100).round()}",
            "${AppString.understand} %${((AppString.understandLength / preExamQuestions.length) * 100).round()}",
            "${AppString.application} %${((AppString.applicationLength / preExamQuestions.length) * 100).round()}",
            "${AppString.analysis} %${((AppString.analysisLength / preExamQuestions.length) * 100).round()}",
            "${AppString.evaluation} %${((AppString.evaluationLength / preExamQuestions.length) * 100).round()}",
            "اجابة خاطئة",
            //"لم يتم الإجابة",
          ],
          values: [
            (userAnswersPrePostExamAnalysis["remember"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["understand"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["application"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["analysis"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["evaluation"] /
                    preExamQuestions.length) *
                100,
            ((preExamQuestions.length -
                            (userAnswersPrePostExamAnalysis["remember"] +
                                userAnswersPrePostExamAnalysis["understand"] +
                                userAnswersPrePostExamAnalysis["application"] +
                                userAnswersPrePostExamAnalysis["analysis"] +
                                userAnswersPrePostExamAnalysis["evaluation"]))
                        .toDouble() /
                    preExamQuestions.length) *
                100,
          ],
        ),
        const SizedBox(height: 10),
        PieChartSample2(
          color: [
            AppColorsChart.contentColorBlue,
            AppColorsChart.contentColorYellow,
            AppColorsChart.contentColorPurple,
            AppColorsChart.contentColorGreen,
            AppColorsChart.contentColorOrange,
            AppColorsChart.pageBackground,
          ],
          length: 6,
          isColumn: true,
          text: [
            "${AppString.exam1Title} %${((AppString.exam1Length / preExamQuestions.length) * 100).round()}",
            "${AppString.exam2Title} %${((AppString.exam2Length / preExamQuestions.length) * 100).round()}",
            "${AppString.exam3Title} %${((AppString.exam3Length / preExamQuestions.length) * 100).round()}",
            "${AppString.exam4Title} %${((AppString.exam4Length / preExamQuestions.length) * 100).round()}",
            "${AppString.exam5Title} %${((AppString.exam5Length / preExamQuestions.length) * 100).round()}",
            "اجابة خاطئة",
            //"لم يتم الإجابة",
          ],
          values: [
            (userAnswersPrePostExamAnalysis["exam1Score"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["exam2Score"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["exam3Score"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["exam4Score"] /
                    preExamQuestions.length) *
                100,
            (userAnswersPrePostExamAnalysis["exam5Score"] /
                    preExamQuestions.length) *
                100,
            ((preExamQuestions.length -
                            (userAnswersPrePostExamAnalysis["exam1Score"] +
                                userAnswersPrePostExamAnalysis["exam2Score"] +
                                userAnswersPrePostExamAnalysis["exam3Score"] +
                                userAnswersPrePostExamAnalysis["exam4Score"] +
                                userAnswersPrePostExamAnalysis["exam5Score"]))
                        .toDouble() /
                    preExamQuestions.length) *
                100,
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
