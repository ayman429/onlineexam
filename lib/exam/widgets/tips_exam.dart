import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Auth/components/custom_button_auth.dart';
import '../../core/constant/app_color.dart';
import '0_pre_exam.dart';
import '1_first_exam.dart';
import '2_second_exam.dart';
import '3_third_exam.dart';
import '4_fourth_exam.dart';
import '5_fifth_exam.dart';
import '6_post_exam.dart';
import 'tips_text.dart';

class TipsExam extends StatefulWidget {
  const TipsExam(
      {super.key,
      required this.value,
      this.userAnswers,
      required this.tipsExamAppBarTitle,
      required this.pdf,
      required this.examLength});
  final int value;
  final Map<String, dynamic>? userAnswers;
  final String tipsExamAppBarTitle;
  final String pdf;
  final double examLength;

  @override
  State<TipsExam> createState() => _TipsExamState();
}

class _TipsExamState extends State<TipsExam> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool isLoading = false;
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
          widget.tipsExamAppBarTitle,
          style: TextStyle(
              color: AppColor.textColor1,
              fontSize: widget.value == 0 || widget.value == 6
                  ? MediaQuery.sizeOf(context).width * 0.08
                  : MediaQuery.sizeOf(context).width * 0.05, //0.048,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => TipsText(value: widget.value),
        //           ));
        //     },
        //     icon: Icon(Icons.tips_and_updates, color: Colors.yellow[800]),
        //   ),
        //   const SizedBox(width: 10),
        // ],
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
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height - 90,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TipsText(value: widget.value),
              // SizedBox(height: 200),

              Container(
                height: 150,
                width: MediaQuery.sizeOf(context).width,
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
                    const Text(
                      "إذا كنت مستعدًا لبدء التدريب الخاص بك، اضغط على 'ابدأ'.",
                      style: TextStyle(
                          color: AppColor.textColor3,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonAuth(
                            isloading: isLoading,
                            text: "ابدأ",
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              final bool isConnected =
                                  await InternetConnectionChecker
                                      .instance.hasConnection;
                              setState(() {
                                isLoading = false;
                              });
                              if (isConnected) {
                                switch (widget.value) {
                                  case 0:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PreExam(
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                  case 1:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FirstExam(
                                            examLength: widget.examLength,
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                  case 2:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SecondExam(
                                            examLength: widget.examLength,
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                  case 3:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ThirdExam(
                                            examLength: widget.examLength,
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                  case 4:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FourthExam(
                                            examLength: widget.examLength,
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                  case 5:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FifthExam(
                                            examLength: widget.examLength,
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                  case 6:
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostExam(
                                            userAnswers:
                                                widget.userAnswers ?? {}),
                                      ),
                                      (route) => false,
                                    );
                                    break;
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Center(
                                    child: Text("لا يوجد اتصال بالإنترنت",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Stack(
      //   alignment: Alignment.bottomCenter,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(bottom: 150),
      //       child: SfPdfViewerTheme(
      //           data: SfPdfViewerThemeData(
      //               backgroundColor: widget.value == 2
      //                   ? Colors.white
      //                   : AppColor.backgroundColor1 // Colors.white,
      //               ),
      //           child: SfPdfViewer.asset(widget.pdf,
      //               key: _pdfViewerKey, canShowPaginationDialog: false)),
      //     ),
      //     Container(
      //       height: 150,
      //       width: MediaQuery.sizeOf(context).width,
      //       padding: const EdgeInsets.all(10),
      //       decoration: BoxDecoration(
      //         color: AppColor.backgroundColor4,
      //         borderRadius: BorderRadius.circular(10),
      //         boxShadow: const [
      //           BoxShadow(
      //             color: Color(0xFFc9d3de),
      //             blurRadius: 6,
      //             spreadRadius: 4,
      //             offset: Offset(2, 4),
      //           ),
      //         ],
      //       ),
      //       child: Column(
      //         children: [
      //           const Text(
      //             "إذا كنت مستعدًا لبدء التدريب الخاص بك، اضغط على 'ابدأ'.",
      //             style: TextStyle(
      //                 color: AppColor.textColor3,
      //                 fontSize: 18,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //           const SizedBox(height: 10),
      //           Row(
      //             children: [
      //               Expanded(
      //                 child: ElevatedButton(
      //                   style: ElevatedButton.styleFrom(
      //                     shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(8)),
      //                     backgroundColor: AppColor.backgroundColor3,
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 20, vertical: 10),
      //                   ),
      //                   onPressed: () {
      //                     switch (widget.value) {
      //                       case 0:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => PreExam(
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                       case 1:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => FirstExam(
      //                                 examLength: widget.examLength,
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                       case 2:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => SecondExam(
      //                                 examLength: widget.examLength,
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                       case 3:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => ThirdExam(
      //                                 examLength: widget.examLength,
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                       case 4:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => FourthExam(
      //                                 examLength: widget.examLength,
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                       case 5:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => FifthExam(
      //                                 examLength: widget.examLength,
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                       case 6:
      //                         Navigator.pushAndRemoveUntil(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => PostExam(
      //                                 userAnswers: widget.userAnswers ?? {}),
      //                           ),
      //                           (route) => false,
      //                         );
      //                         break;
      //                     }
      //                   },
      //                   child: const Text(
      //                     "ابدأ",
      //                     style: TextStyle(
      //                         color: AppColor.textColor3,
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 20),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
