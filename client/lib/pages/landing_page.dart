import 'package:flutter/material.dart';
import 'package:sleepapp/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String startValue =
      "0"; // start time slept measured in minutes of datatype int
  String endValue = "0";

  String averageSleep = "";
  String slept = "";
  String totalSleep = "";

  @override
  void initState() {
    // initialize averageSleep & totalSleep at launch
    super.initState();
    getStats(globalUsername);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $globalUsername',
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/login'); // logout button
            showMessage('Successfully logged out');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              // average sleep
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Average Sleep : ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$averageSleep Hours Slept',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // total sleep
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total Sleep : ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$slept / $totalSleep Hours',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // start time
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Start Time : ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        DropdownButton<String>(
                          value: startValue,
                          style:
                              const TextStyle(fontSize: 24, color: Colors.blue),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              startValue = newValue!;
                            });
                          },
                          items:
                              buildDropdownMenuItems(), // build drop down arrow selections which get repetitive
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // end time
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "End Time : ",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        DropdownButton<String>(
                          value: endValue,
                          style:
                              const TextStyle(fontSize: 24, color: Colors.blue),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              endValue = newValue!;
                            });
                          },
                          items: buildDropdownMenuItems(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // add button
              SizedBox(
                height: 120,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (startValue != endValue) {
                        await createEntry(globalUsername, startValue,
                            endValue); // create a sleep record if the start time and ending time differ
                        getStats(
                            globalUsername); // then refresh the page with updated sleep record
                        return showMessage('Sleep log added!');
                      } else {
                        return showMessage(
                            'Start time cant be the same as end time!');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue[900],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.timeline,
                    size: 36,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/stats');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // function to build dropdown menu items
  List<DropdownMenuItem<String>> buildDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i <= 1410; i += 30) {
      String value = i.toString();
      String hour = (i ~/ 60).toString().padLeft(2, '0');
      String minute = (i % 60).toString().padLeft(2, '0');
      items.add(
        DropdownMenuItem<String>(
          value: value,
          child: Text('$hour:$minute'),
        ),
      );
    }
    return items;
  }

  Future<void> getStats(String username) async {
    // get the averageSlept time, time slept and amount needed for sleep
    String server = 'http://129.80.148.244:3001';

    final response = await http.post(
      Uri.parse('$server/getAverages'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{'user': username},
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String averageSleepTime = data['averageDuration'] ?? '00:00';
      String totalRest = data['totalRest'] ?? '00:00';
      String qtyRestNeeded = data['qtyRestNeeded'] ?? '00:00';

      setState(() {
        averageSleep = averageSleepTime;
        totalSleep = qtyRestNeeded;
        slept = totalRest;
      });
    }
  }

  Future<http.Response> createEntry(String username, startTime, endTime) async {
    // store a Sleep Record with starting end ending time
    String server = 'http://129.80.148.244:3001';

    return await http.post(
      Uri.parse('$server/createRecord'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'user': username,
          'start_time': startTime,
          'end_time': endTime
        },
      ),
    );
  }
}
