import 'package:flutter/material.dart';

import '../../core/constant/app_string.dart';
import 'text_field_component.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.emailController,
    this.validator,
  });

  final TextEditingController emailController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFieldComponent(
      nameController: emailController,
      keyboardType: TextInputType.emailAddress,
      hintText: AppString.enterEmail,
      prefixIcon: const Icon(Icons.email),
      validator: validator,
    );
  }
}
