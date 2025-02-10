import 'package:flutter/material.dart';
import 'package:onlineexam/core/constant/app_color.dart';

showDialogIndexExam(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Center(
          child: Text(
              textAlign: TextAlign.center, "يجب حل الاختبارات السابقة اولا")),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "موافق",
              style: TextStyle(color: AppColor.primaryColor, fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}
