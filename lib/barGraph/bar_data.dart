import 'package:sleepapp/barGraph/individual_bar.dart';

class BarData {
  final double sunData;
  final double monData;
  final double tueData;
  final double wedData;
  final double thuData;
  final double friData;
  final double satData;

  BarData({
    required this.sunData,
    required this.monData,
    required this.tueData,
    required this.wedData,
    required this.thuData,
    required this.friData,
    required this.satData,
  });

  List<IndividualBar> barData = [];

  void initBarData() {
    barData = [
      IndividualBar(x: 0, y: sunData),
      IndividualBar(x: 1, y: monData),
      IndividualBar(x: 2, y: tueData),
      IndividualBar(x: 3, y: wedData),
      IndividualBar(x: 4, y: thuData),
      IndividualBar(x: 5, y: friData),
      IndividualBar(x: 6, y: satData),
    ];
  }
}
