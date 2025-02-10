import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import 'text_field_component.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.passwordController,
    this.validator,
  });

  final TextEditingController passwordController;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldComponent(
      nameController: widget.passwordController,
      validator: widget.validator,
      hintText: AppString.enterPassword,
      obscureText: obscureText,
      prefixIcon: const Icon(Icons.password),
      suffixIcon: IconButton(
        icon: obscureText
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    );
  }
}
