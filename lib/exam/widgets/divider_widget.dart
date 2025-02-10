import 'package:flutter/material.dart';

import '../../core/constant/app_color.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
    this.hasChange,
  });
  final bool? hasChange;

  @override
  Widget build(BuildContext context) {
    print(hasChange.toString());
    bool hasChange2 = false;
    hasChange.toString() == "null" ? hasChange2 = false : hasChange2 = true;
    return hasChange2
        ? Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFc9d3de),
                  blurRadius: 6,
                  spreadRadius: 4,
                  offset: Offset(2, 4),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: hasChange2 ? 0 : 5),
            child: Divider(
              thickness: hasChange2 ? 5 : 0.3,
              color: Colors
                  .grey, //AppColor.backgroundColor2,AppColor.backgroundColor3
            ),
          );
  }
}
