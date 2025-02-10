import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/constant/app_color.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({
    super.key,
    required this.nameController,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController nameController;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: nameController,
      cursorColor: AppColor.textColor3,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: AppColor.textColor1,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: AppColor.textColor3,
        suffixIconColor: AppColor.textColor3,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.textColor3,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
