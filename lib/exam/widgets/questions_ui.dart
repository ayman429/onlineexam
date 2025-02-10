import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/constant/app_color.dart';
import '../components/custom_radio_answer.dart';

class QuestionsUi extends StatelessWidget {
  const QuestionsUi(
      {super.key,
      this.onChanged,
      required this.radioValue,
      required this.index,
      required this.examQuestions,
      required this.isAnswered,
      required this.showQuestionButton,
      required this.isShowAnswer,
      this.rightAnswer});
  final Function(int?)? onChanged;
  final int radioValue;
  final int index;
  final Map<String, dynamic> examQuestions;
  final bool showQuestionButton;
  final int? rightAnswer;
  final bool isAnswered;
  final bool isShowAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              isAnswered
                  ? radioValue == 0
                      ? Row(
                          children: [
                            const Icon(Icons.close,
                                color: AppColor.iconColor2, size: 30),
                            SizedBox(width: 10),
                          ],
                        )
                      : SizedBox()
                  : SizedBox(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    showQuestionButton
                        ? examQuestions['Q'].toString()
                        : examQuestions['q'].toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isShowAnswer ? Colors.grey : AppColor.textColor3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomAnswer(
            isShowAnswer: isShowAnswer,
            examQuestions: examQuestions['A1'],
            value: 1,
            radioValue: radioValue,
            onChanged: onChanged,
            isAnswered: isAnswered,
            rightAnswer: rightAnswer,
          ),
          const SizedBox(height: 10),
          CustomAnswer(
            isShowAnswer: isShowAnswer,
            examQuestions: examQuestions['A2'],
            value: 2,
            radioValue: radioValue,
            onChanged: onChanged,
            isAnswered: isAnswered,
            rightAnswer: rightAnswer,
          ),
          const SizedBox(height: 10),
          examQuestions['isTF']
              ? const SizedBox()
              : CustomAnswer(
                  isShowAnswer: isShowAnswer,
                  examQuestions: examQuestions['A3'],
                  value: 3,
                  radioValue: radioValue,
                  onChanged: onChanged,
                  isAnswered: isAnswered,
                  rightAnswer: rightAnswer,
                ),
          const SizedBox(height: 10),
          examQuestions['isTF']
              ? const SizedBox()
              : CustomAnswer(
                  isShowAnswer: isShowAnswer,
                  examQuestions: examQuestions['A4'],
                  value: 4,
                  radioValue: radioValue,
                  onChanged: onChanged,
                  isAnswered: isAnswered,
                  rightAnswer: rightAnswer,
                ),
        ],
      ),
    );
  }
}

class CustomAnswer extends StatelessWidget {
  const CustomAnswer({
    super.key,
    required this.examQuestions,
    required this.radioValue,
    required this.onChanged,
    required this.isAnswered,
    this.rightAnswer,
    required this.value,
    required this.isShowAnswer,
  });

  final String examQuestions;
  final int radioValue;
  final Function(int? p1)? onChanged;
  final bool isAnswered;
  final int? rightAnswer;
  final int value;
  final bool isShowAnswer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("==================");
        onChanged!(value);
      },
      child: Row(
        children: [
          CustomRadioAnswer(
            rightAnswer: rightAnswer,
            isAnswered: isAnswered,
            isShowAnswer: isShowAnswer,
            examQuestion: examQuestions,
            value: value,
            radioValue: radioValue,
            onChanged: onChanged,
          ),
          // isAnswered ? const Spacer() : const SizedBox(),
          // isAnswered
          //     ? radioValue == rightAnswer
          //         ? radioValue == value
          //             ? const Icon(Icons.check,
          //                 color: AppColor.iconColor3, size: 30)
          //             : const SizedBox()
          //         : radioValue == value
          //             ? const Icon(Icons.close, color: AppColor.iconColor2)
          //             : const SizedBox()
          //     : const SizedBox(),
          // isAnswered
          //     ? radioValue != rightAnswer
          //         ? rightAnswer == value
          //             ? const Icon(Icons.check,
          //                 color: AppColor.iconColor3, size: 30)
          //             : const SizedBox()
          //         : const SizedBox()
          //     : const SizedBox(),
          // isAnswered ? const SizedBox(width: 10) : const SizedBox(),
        ],
      ),
    );
  }
}
