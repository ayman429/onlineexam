import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart1 extends StatelessWidget {
  const Chart1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      color: Colors.blueGrey[900],
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: LineChartWidget(),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(duration: const Duration(milliseconds: 250), sampleData1);
  }
}

LineChartData get sampleData1 => LineChartData(
      gridData: gridData,
      titlesData: titlesData,
      borderData: borderData,
      lineBarsData: lineBarsData,
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 5,
    );
List<LineChartBarData> get lineBarsData => [
      lineCharBarData1,
      // lineCharBarData2,
    ];

FlTitlesData get titlesData => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: leftTitles,
      ),
    );
Widget leftTitlesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '1m';
      break;
    case 2:
      text = '2m';
      break;
    case 3:
      text = '3m';
      break;
    case 4:
      text = '4m';
      break;
    case 5:
      text = '5m';
      break;
    default:
      return Container();
  }
  return Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}

SideTitles get leftTitles => const SideTitles(
      getTitlesWidget: leftTitlesWidget,
      showTitles: true,
      interval: 1,
      reservedSize: 40,
    );

Widget buttomTitlesWidget(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  Widget text;
  switch (value.toInt()) {
    case 3:
      text = const Text("جلسة 1", style: style);
      break;
    case 6:
      text = const Text("جلسة 2", style: style);
      break;
    case 9:
      text = const Text("جلسة 3", style: style);
      break;
    case 12:
      text = const Text("جلسة 4", style: style);
      break;

    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(
    meta: meta,
    space: 10,
    child: text,
  );
}

SideTitles get bottomTitles => const SideTitles(
      getTitlesWidget: buttomTitlesWidget,
      showTitles: true,
      interval: 1,
      reservedSize: 32,
    );

FlGridData get gridData => const FlGridData(show: true);

FlBorderData get borderData => FlBorderData(
      border: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 4,
        ),
        left: BorderSide(
          color: Colors.grey,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    );

LineChartBarData get lineCharBarData1 => LineChartBarData(
      isCurved: true,
      color: Colors.purple,
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        const FlSpot(3, 0),
        const FlSpot(6, 1),
        const FlSpot(9, 1),
        const FlSpot(12, 1),
        // const FlSpot(10, 1),
        // const FlSpot(12, 1),
        // const FlSpot(13, 1),
      ],
    );

LineChartBarData get lineCharBarData2 => LineChartBarData(
      isCurved: true,
      color: Colors.red,
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        const FlSpot(1, 2),
        const FlSpot(3, 1),
        const FlSpot(5, 3),
        const FlSpot(7, 3.4),
        const FlSpot(10, 2.3),
        const FlSpot(12, 2.9),
        const FlSpot(13, 3),
      ],
    );
