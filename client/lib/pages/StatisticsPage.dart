import 'package:flutter/material.dart';
import 'package:sleepapp/barGraph/BarGraph.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<double> barWeek = [10.0, 6.0, 6.5, 7.5, 7.0, 6.0, 10.5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(children: [
        //All Sleep
        Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            height: 100,
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Overall Sleep",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ])),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            height: 200,
            child: BarGraph(
              barWeek: barWeek,
            )),

        //Week Sleep
        Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            height: 100,
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "This Weeks Sleep",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ])),
        //bargraph
        Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            height: 200,
            child: BarGraph(
              barWeek: barWeek,
            )),

        //Widgets
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
          height: 150,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.home,
                        size: 36,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/landing');
                      },
                    ))
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
