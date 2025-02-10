import 'package:flutter/material.dart';

class CustomButtonNextBackScreen extends StatelessWidget {
  const CustomButtonNextBackScreen({
    super.key,
    this.onPressed,
    required this.icon,
    required this.color,
  });
  final void Function()? onPressed;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Padding(
            padding: const EdgeInsets.all(7),
            child: Icon(icon, color: color),
          ),
        ),
      ),
    );
  }
}
