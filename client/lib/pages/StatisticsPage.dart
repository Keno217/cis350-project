import 'package:flutter/material.dart';
import 'package:sleepapp/barGraph/BarGraph.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sleepapp/global.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<double> barWeek = [0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    getSleepStats();
  }

  Future<void> getSleepStats() async {
    String server = 'http://129.80.148.244:3001';

    var response = await http.post(
      Uri.parse('$server/getSleepStats'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{'user': globalUsername},
      ),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var duration = data['durations'] as List<dynamic>;

      setState(() {
        barWeek = duration
            .map<double>((value) => (value as num).toDouble())
            .toList(); // iterates through map 'duration' and casts them into a float, then stored into a list
      });
    } else {
      print('Failed to load sleep stats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // All Sleep
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                height: 100,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Last Weeks Sleep",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 71, 161),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                height: 200,
                child: BarGraph(
                  barWeek: barWeek,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue[900],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.home,
                    size: 36,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/landing');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
