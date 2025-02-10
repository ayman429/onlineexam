import 'package:flutter/material.dart';

import '../../core/constant/app_color.dart';

class CustomNameItem extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String itemName;
  final Color? color;
  const CustomNameItem(
      {super.key,
      this.onTap,
      required this.icon,
      required this.itemName,
      this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    itemName,
                    style: TextStyle(
                        color: AppColor.textColor1, //AppColor.primaryColor,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            thickness: 5,
            color: AppColor.backgroundColor3,
          ),
        ),
      ],
    );
  }
}
