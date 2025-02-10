import 'package:flutter/material.dart';
import 'package:onlineexam/core/constant/app_color.dart';

showDialogFinish(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColor.backgroundColor3,
      title: const Center(
          child: Text(
        textAlign: TextAlign.center,
        "لا يمكن دخول الاختبار اكثر من مرة",
        style: TextStyle(color: AppColor.textColor1),
      )),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "موافق",
              style: TextStyle(
                  color: AppColor.textColor3,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}
