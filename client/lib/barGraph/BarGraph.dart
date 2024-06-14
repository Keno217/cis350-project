import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sleepapp/barGraph/BarData.dart';

class BarGraph extends StatelessWidget {
  final List barWeek;
  const BarGraph({super.key, required this.barWeek});

  @override
  Widget build(BuildContext context) {
    BarData data = BarData(
        sunData: barWeek[0],
        monData: barWeek[1],
        tueData: barWeek[2],
        wedData: barWeek[3],
        thuData: barWeek[4],
        friData: barWeek[5],
        satData: barWeek[6]);

    data.initBarData();

    return BarChart(BarChartData(
        maxY: 24,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTiles,
            )),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        barGroups: data.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      width: 25,
                      borderRadius: BorderRadius.circular(7))
                ]))
            .toList()));
  }
}

class style {
  const style();
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.teal);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('S', style: style);
      break;
    case 1:
      text = const Text('M', style: style);
      break;
    case 2:
      text = const Text('T', style: style);
      break;
    case 3:
      text = const Text('W', style: style);
      break;
    case 4:
      text = const Text('T', style: style);
      break;
    case 5:
      text = const Text('F', style: style);
      break;
    case 6:
      text = const Text('S', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
