import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sleepapp/global.dart';
import 'package:sleepapp/barGraph/BarGraph.dart'; // Assuming you have a BarGraph widget

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<double> barWeek = [0, 0, 0, 0, 0, 0, 0];
  List<Map<String, dynamic>> sleepRecords = [];

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
      var records = data['records'] as List<dynamic>;

      setState(() {
        barWeek =
            duration.map<double>((value) => (value as num).toDouble()).toList();

        // Assuming 'records' is an array of sleep record objects
        sleepRecords = records
            .map<Map<String, dynamic>>((record) => {
                  'id': record['id'],
                  'user': record['user'],
                  'startTime': record['startTime'],
                  'endTime': record['endTime'],
                  'date': record['date'],
                  'duration': record['duration'],
                })
            .toList();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Graph Section
          Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: Column(
              children: [
                Text(
                  "Last Week's Sleep",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 13, 71, 161),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: barGraph(
                      barWeek: barWeek), // Replace with your BarGraph widget
                ),
              ],
            ),
          ),

          // Sleep Records Section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Grey outline border
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: sleepRecords.length,
                itemBuilder: (context, index) {
                  var record = sleepRecords[index];
                  return ListTile(
                    title: Text('ID: ${record['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User: ${record['user']}'),
                        Text('Date: ${record['date']}'),
                        Text('Start Time: ${record['startTime']}'),
                        Text('End Time: ${record['endTime']}'),
                        Text('Duration: ${record['duration']} minutes'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Home Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20), // Adjusted to 60 to move it further down
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
