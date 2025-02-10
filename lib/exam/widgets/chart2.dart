import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constant/app_color.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2(
      {super.key,
      required this.text,
      required this.values,
      required this.isColumn,
      required this.length,
      required this.color});
  final List<String> text;
  final List<double> values;
  final bool isColumn;
  final int length;
  final List<Color> color;
  @override
  State<PieChartSample2> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width - 30,
      ),
      height: widget.isColumn ? 400 : 300,
      // margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor4,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFc9d3de),
            blurRadius: 6,
            spreadRadius: 4,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              // const SizedBox(
              //   height: 18,
              // ),
              Expanded(
                child: SizedBox(
                  height: 200,
                  // aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),

              // const SizedBox(
              //   width: 28,
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: widget.isColumn
                ? Column(
                    children: [
                      IndicatorCol1(
                        widget: widget,
                        length: widget.length,
                        color: widget.color,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      IndicatorCol2(
                        widget: widget,
                        length: widget.length,
                        color: widget.color,
                      ),
                    ],
                  )
                : Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: IndicatorCol1(
                        widget: widget,
                        length: widget.length,
                        color: widget.color,
                      )),
                      const SizedBox(
                        width: 20,
                      ),

                      Expanded(
                          child: IndicatorCol2(
                        widget: widget,
                        length: widget.length,
                        color: widget.color,
                      )),
                      // SizedBox(
                      //   height: 18,
                      // ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: widget.color[0], //AppColorsChart.contentColorBlue,
            value: widget.values[0],
            title: '${widget.values[0].round()}%',
            titlePositionPercentageOffset: .7,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColorsChart.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: widget.color[1], //AppColorsChart.contentColorYellow,
            value: widget.values[1],
            title: '${widget.values[1].round()}%',
            titlePositionPercentageOffset: .7,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColorsChart.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: widget.color[2], //AppColorsChart.contentColorPurple,
            value: widget.values[2],
            title: '${widget.values[2].round()}%',
            titlePositionPercentageOffset: .7,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColorsChart.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: widget.color[3], //AppColorsChart.contentColorGreen,
            value: widget.values[3],
            title: '${widget.values[3].round()}%',
            titlePositionPercentageOffset: .7,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColorsChart.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: widget.color[4], //AppColorsChart.contentColorOrange,
            value: widget.values[4],
            title: '${widget.values[4].round()}%',
            titlePositionPercentageOffset: .7,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColorsChart.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color: widget.color[5], //AppColorsChart.pageBackground,
            value: widget.values[5],
            title: '${widget.values[5].round()}%',
            titlePositionPercentageOffset: .7,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColorsChart.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class IndicatorCol2 extends StatelessWidget {
  const IndicatorCol2({
    super.key,
    required this.widget,
    required this.length,
    required this.color,
  });

  final PieChartSample2 widget;
  final int length;
  final List<Color> color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Indicator(
          color: widget.color[3], //AppColorsChart.contentColorGreen,
          text: widget.text[3],
          isSquare: true,
        ),
        const SizedBox(
          height: 4,
        ),
        Indicator(
          color: widget.color[4], //AppColorsChart.contentColorOrange,
          text: widget.text[4],
          isSquare: true,
        ),
        const SizedBox(
          height: 4,
        ),
        length == 6
            ? Indicator(
                color: widget.color[5], //AppColorsChart.pageBackground,
                text: widget.text[5],
                isSquare: true,
              )
            : SizedBox(),
      ],
    );
  }
}

class IndicatorCol1 extends StatelessWidget {
  const IndicatorCol1({
    super.key,
    required this.widget,
    required this.length,
    required this.color,
  });

  final PieChartSample2 widget;
  final int length;
  final List<Color> color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Indicator(
          color: widget.color[0], //AppColorsChart.contentColorBlue,
          text: widget.text[0],
          isSquare: true,
        ),
        const SizedBox(
          height: 4,
        ),
        Indicator(
          color: widget.color[1], //AppColorsChart.contentColorYellow,
          text: widget.text[1],
          isSquare: true,
        ),
        const SizedBox(
          height: 4,
        ),
        Indicator(
          color: widget.color[2], //AppColorsChart.contentColorPurple,
          text: widget.text[2],
          isSquare: true,
        )
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            maxLines: 2,
          ),
        )
      ],
    );
  }
}

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
