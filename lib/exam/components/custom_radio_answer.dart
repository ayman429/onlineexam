import 'package:flutter/material.dart';
import 'package:onlineexam/core/constant/app_color.dart';

class CustomRadioAnswer extends StatelessWidget {
  const CustomRadioAnswer(
      {super.key,
      required this.value,
      required this.radioValue,
      this.onChanged,
      required this.examQuestion,
      required this.isShowAnswer,
      required this.isAnswered,
      this.rightAnswer});
  final int value;
  final void Function(int?)? onChanged;
  final String examQuestion;
  final int radioValue;
  final bool isShowAnswer;
  final bool isAnswered;
  final int? rightAnswer;
  Widget getSpaces() {
    List<bool> spaces = [false, false, false, false];

    isAnswered
        ? radioValue == rightAnswer
            ? radioValue == value
                ? spaces[value - 1] = true
                : const SizedBox()
            : radioValue == value
                ? spaces[value - 1] = true
                : const SizedBox()
        : const SizedBox();
    isAnswered
        ? radioValue != rightAnswer
            ? rightAnswer == value
                ? spaces[value - 1] = true
                : const SizedBox()
            : const SizedBox()
        : const SizedBox();
    return spaces[value - 1] ? SizedBox() : const SizedBox(width: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          isAnswered
              ? Row(
                  children: [
                    isAnswered
                        ? radioValue == rightAnswer
                            ? radioValue == value
                                ? const Icon(Icons.check,
                                    color: AppColor.iconColor3, size: 30)
                                : const SizedBox()
                            : radioValue == value
                                ? const Icon(Icons.close,
                                    color: AppColor.iconColor2, size: 30)
                                : const SizedBox()
                        : const SizedBox(),
                    isAnswered
                        ? radioValue != rightAnswer
                            ? rightAnswer == value
                                ? const Icon(Icons.check,
                                    color: AppColor.iconColor3, size: 30)
                                : const SizedBox()
                            : const SizedBox()
                        : const SizedBox(),
                    // -----------------------------------------------------
                    getSpaces(),
                    Radio(
                      // activeColor: AppColor.primaryColor,
                      fillColor: WidgetStateProperty.all(
                          isShowAnswer ? Colors.grey : AppColor.textColor3),
                      value: value,
                      groupValue: radioValue,
                      onChanged: onChanged,
                    ),
                  ],
                )
              : Radio(
                  // activeColor: AppColor.primaryColor,
                  fillColor: WidgetStateProperty.all(
                      isShowAnswer ? Colors.grey : AppColor.textColor3),
                  value: value,
                  groupValue: radioValue,
                  onChanged: onChanged),
          const SizedBox(width: 10),
          Expanded(
              child: Text(examQuestion,
                  style: TextStyle(
                      color: isShowAnswer ? Colors.grey : AppColor.textColor1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
