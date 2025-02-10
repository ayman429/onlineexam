import 'package:flutter/material.dart';

import '../../core/constant/app_color.dart';

class CustomTextContainer extends StatelessWidget {
  const CustomTextContainer({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;

  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: AppColor.textColor1,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(
                //horizontal: e[examScore] == -1 ? 10 : 16,
                vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.backgroundColor4, //AppColor.backgroundColor4,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey, //Color(0xFFb1feb1),
                  blurRadius: 3, // مقدار التمويه
                  spreadRadius: 0.2, // مدى انتشار الظل
                  // offset: Offset(
                  //     2, 4), // تحريك الظل (X, Y)
                ),
              ],
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                    color:
                        // AppColor.textColor3
                        AppColor.iconColor3,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
