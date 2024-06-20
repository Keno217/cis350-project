import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sleepapp/barGraph/BarData.dart';

class BarGraph extends StatelessWidget {
  final List barWeek;
  const BarGraph({super.key, required this.barWeek});

  @override
  Widget build(BuildContext context) {
    BarData data = BarData(
        sunData: barWeek.length >= 1 ? barWeek[0] : 0,
        monData: barWeek.length >= 2 ? barWeek[1] : 0,
        tueData: barWeek.length >= 3 ? barWeek[2] : 0,
        wedData: barWeek.length >= 4 ? barWeek[3] : 0,
        thuData: barWeek.length >= 5 ? barWeek[4] : 0,
        friData: barWeek.length >= 6 ? barWeek[5] : 0,
        satData: barWeek.length >= 7 ? barWeek[6] : 0);

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
