import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample7 extends StatefulWidget {
  BarChartSample7(
      {super.key,
      required this.showYaxis,
      required this.userAnswersCountPrePostExam,
      required this.rightAnswers,
      required this.userNamber});

  final shadowColor = const Color(0xFFCCCCCC);
  final Map<String, dynamic> userAnswersCountPrePostExam;
  final bool showYaxis;
  final int rightAnswers;
  final int userNamber;

  //  dataList = [
  //     _BarData(AppColorsChart.itemsBackground,
  //        userAnswersCountPrePostExam["a0"], 25),
  //     _BarData(AppColorsChart.contentColorGreen,
  //         userAnswersCountPrePostExam["a4"], 8),
  //     _BarData(AppColorsChart.contentColorOrange,
  //         userAnswersCountPrePostExam["a3"], 15),
  //     _BarData(AppColorsChart.contentColorPink,
  //        userAnswersCountPrePostExam["a2"], 5),
  //     _BarData(AppColorsChart.contentColorBlue,
  //         userAnswersCountPrePostExam["a1"], 2.5),
  //   ];

  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 10,
        ),
        // BarChartRodData(
        //   toY: shadowValue,
        //   color: widget.shadowColor,
        //   width: 6,
        // ),
        // BarChartRodData(
        //   toY: value,
        //   color: color,
        //   width: 6,
        // ),
        // BarChartRodData(
        //   toY: shadowValue,
        //   color: widget.shadowColor,
        //   width: 6,
        // ),
        // BarChartRodData(
        //   toY: value,
        //   color: color,
        //   width: 6,
        // ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int rotationTurns = 1;

  @override
  Widget build(BuildContext context) {
    var dataList = [
      _BarData(AppColorsChart.itemsBackground,
          widget.userAnswersCountPrePostExam["a0"].toDouble(), 25),
      _BarData(
          widget.rightAnswers == 4
              ? AppColorsChart.contentColorGreen
              : AppColorsChart.contentColorOrange,
          widget.userAnswersCountPrePostExam["a4"].toDouble(),
          8),
      _BarData(
          widget.rightAnswers == 3
              ? AppColorsChart.contentColorGreen
              : AppColorsChart.contentColorOrange,
          widget.userAnswersCountPrePostExam["a3"].toDouble(),
          15),
      _BarData(
          widget.rightAnswers == 2
              ? AppColorsChart.contentColorGreen
              : AppColorsChart.contentColorOrange,
          widget.userAnswersCountPrePostExam["a2"].toDouble(),
          5),
      _BarData(
          widget.rightAnswers == 1
              ? AppColorsChart.contentColorGreen
              : AppColorsChart.contentColorOrange,
          widget.userAnswersCountPrePostExam["a1"].toDouble(),
          2.5),
    ];
    return Container(
      // padding: EdgeInsets.only(right: widget.showYaxis ? 10 : 0, top: 30),
      // margin: EdgeInsets.only(right: widget.showYaxis ? 10 : 0, top: 10),
      width: 250,
      height: 300,
      // decoration: BoxDecoration(
      //   color: AppColor.backgroundColor4,
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: const [
      //     BoxShadow(
      //       color: Color(0xFFc9d3de),
      //       blurRadius: 6,
      //       spreadRadius: 4,
      //       offset: Offset(2, 4),
      //     ),
      //   ],
      // ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Expanded(child: Container()),
            //     const Text(
            //       'Horizontal Bar Chart',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 20,
            //       ),
            //     ),
            //     Expanded(
            //         child: Align(
            //       alignment: Alignment.centerRight,
            //       child: Tooltip(
            //         message: 'Rotate the chart 90 degrees (cw)',
            //         child: IconButton(
            //           onPressed: () {
            //             setState(() {
            //               rotationTurns += 1;
            //             });
            //           },
            //           icon: RotatedBox(
            //             quarterTurns: rotationTurns - 1,
            //             child: const Icon(
            //               Icons.rotate_90_degrees_cw,
            //             ),
            //           ),
            //         ),
            //       ),
            //     )),
            //   ],
            // ),
            // const SizedBox(height: 18),
            Expanded(
              child: BarChart(
                BarChartData(
                  // groupsSpace: 300,
                  // alignment: BarChartAlignment.spaceBetween,
                  // rotationQuarterTurns: rotationTurns,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color:
                            AppColorsChart.borderColor.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          // final index = value.toInt();
                          final index = (dataList.length - 1 - value.toInt());
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              index == 4 ? "none" : "A${index + 1}",
                              style: TextStyle(color: Colors.black),
                            ),
                            //  _IconWidget(
                            //   color: widget.dataList[index].color,
                            //   isSelected: touchedGroupIndex == index,
                            // ),
                          );
                        },
                      ),
                    ),
                    rightTitles: widget.showYaxis
                        ? const AxisTitles(
                            drawBelowEverything: true,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                            ),
                          )
                        : const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColorsChart.borderColor.withValues(alpha: 0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: dataList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(
                      index,
                      data.color,
                      data.value,
                      data.shadowValue,
                    );
                  }).toList(),
                  maxY: widget.userNamber.toDouble(),
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    // touchTooltipData: BarTouchTooltipData(
                    //   getTooltipColor: (group) => Colors.transparent,
                    //   tooltipMargin: 0,
                    //   getTooltipItem: (
                    //     BarChartGroupData group,
                    //     int groupIndex,
                    //     BarChartRodData rod,
                    //     int rodIndex,
                    //   ) {
                    //     return BarTooltipItem(
                    //       rod.toY.toString(),
                    //       TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color: rod.color,
                    //         fontSize: 18,
                    //         shadows: const [
                    //           Shadow(
                    //             color: Colors.black26,
                    //             blurRadius: 12,
                    //           )
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);

  final Color color;
  final double value;
  final double shadowValue;
}

// class _IconWidget extends ImplicitlyAnimatedWidget {
//   const _IconWidget({
//     required this.color,
//     required this.isSelected,
//   }) : super(duration: const Duration(milliseconds: 300));
//   final Color color;
//   final bool isSelected;

//   @override
//   ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
//       _IconWidgetState();
// }

// class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
//   Tween<double>? _rotationTween;

//   @override
//   Widget build(BuildContext context) {
//     final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
//     final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
//     return Transform(
//       transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
//       origin: const Offset(14, 14),
//       child: Icon(
//         widget.isSelected ? Icons.face_retouching_natural : Icons.face,
//         color: widget.color,
//         size: 28,
//       ),
//     );
//   }

//   @override
//   void forEachTween(TweenVisitor<dynamic> visitor) {
//     _rotationTween = visitor(
//       _rotationTween,
//       widget.isSelected ? 1.0 : 0.0,
//       (dynamic value) => Tween<double>(
//         begin: value as double,
//         end: widget.isSelected ? 1.0 : 0.0,
//       ),
//     ) as Tween<double>?;
//   }
// }

class AppColorsChart {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
