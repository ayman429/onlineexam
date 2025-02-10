import 'package:flutter/material.dart';

loadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: const SizedBox(
        height: 10,
        width: 10,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}
