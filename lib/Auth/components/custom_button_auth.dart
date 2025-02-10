import 'package:flutter/material.dart';

import '../../core/constant/app_color.dart';

class CustomButtonAuth extends StatelessWidget {
  const CustomButtonAuth({
    super.key,
    this.onPressed,
    required this.text,
    required this.isloading,
  });
  final void Function()? onPressed;
  final String text;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: AppColor.backgroundColor3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: isloading
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColor.textColor3,
                  ),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                    color: AppColor.textColor3,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ));
  }
}
