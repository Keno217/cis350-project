import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String startValue = "0";
  String endValue = "0";

  String averageSleep = "7:15 Hours";
  String totalSleep = "21:45 / 24:00 Hours";

  String funFactLine1 = "Counting sheep works";
  String funFactLine2 = "becuase sheep sounds like sleep!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(children: [
        //Average Sleep
        Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    averageSleep,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ])),

        //Total Sleep
        Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    totalSleep,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ])),

        //Start Time
        Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              Column(children: [
                Container(
                    child: DropdownButton<String>(
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
                        items: const [
                      DropdownMenuItem<String>(
                        value: "0",
                        child: Text("00:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "30",
                        child: Text("00:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "60",
                        child: Text("01:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "90",
                        child: Text("01:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "120",
                        child: Text("02:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "150",
                        child: Text("02:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "180",
                        child: Text("03:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "210",
                        child: Text("03:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "240",
                        child: Text("04:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "270",
                        child: Text("04:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "300",
                        child: Text("05:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "330",
                        child: Text("05:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "360",
                        child: Text("06:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "390",
                        child: Text("06:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "420",
                        child: Text("07:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "450",
                        child: Text("07:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "480",
                        child: Text("08:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "510",
                        child: Text("08:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "540",
                        child: Text("09:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "570",
                        child: Text("09:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "600",
                        child: Text("10:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "630",
                        child: Text("10:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "660",
                        child: Text("11:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "690",
                        child: Text("11:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "720",
                        child: Text("12:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "750",
                        child: Text("12:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "780",
                        child: Text("13:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "810",
                        child: Text("13:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "840",
                        child: Text("14:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "870",
                        child: Text("14:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "900",
                        child: Text("15:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "930",
                        child: Text("15:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "960",
                        child: Text("16:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "990",
                        child: Text("16:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1020",
                        child: Text("17:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1050",
                        child: Text("17:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1080",
                        child: Text("18:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1110",
                        child: Text("18:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1140",
                        child: Text("19:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1170",
                        child: Text("19:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1200",
                        child: Text("20:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1230",
                        child: Text("20:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1260",
                        child: Text("21:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1290",
                        child: Text("21:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1320",
                        child: Text("22:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1350",
                        child: Text("22:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1380",
                        child: Text("23:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1410",
                        child: Text("23:30"),
                      ),
                    ]))
              ]),
            ])),

        //End time
        Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
            height: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              Column(children: [
                Container(
                    child: DropdownButton<String>(
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
                        items: const [
                      DropdownMenuItem<String>(
                        value: "0",
                        child: Text("00:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "30",
                        child: Text("00:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "60",
                        child: Text("01:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "90",
                        child: Text("01:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "120",
                        child: Text("02:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "150",
                        child: Text("02:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "180",
                        child: Text("03:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "210",
                        child: Text("03:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "240",
                        child: Text("04:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "270",
                        child: Text("04:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "300",
                        child: Text("05:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "330",
                        child: Text("05:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "360",
                        child: Text("06:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "390",
                        child: Text("06:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "420",
                        child: Text("07:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "450",
                        child: Text("07:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "480",
                        child: Text("08:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "510",
                        child: Text("08:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "540",
                        child: Text("09:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "570",
                        child: Text("09:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "600",
                        child: Text("10:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "630",
                        child: Text("10:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "660",
                        child: Text("11:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "690",
                        child: Text("11:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "720",
                        child: Text("12:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "750",
                        child: Text("12:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "780",
                        child: Text("13:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "810",
                        child: Text("13:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "840",
                        child: Text("14:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "870",
                        child: Text("14:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "900",
                        child: Text("15:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "930",
                        child: Text("15:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "960",
                        child: Text("16:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "990",
                        child: Text("16:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1020",
                        child: Text("17:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1050",
                        child: Text("17:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1080",
                        child: Text("18:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1110",
                        child: Text("18:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1140",
                        child: Text("19:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1170",
                        child: Text("19:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1200",
                        child: Text("20:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1230",
                        child: Text("20:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1260",
                        child: Text("21:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1290",
                        child: Text("21:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1320",
                        child: Text("22:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1350",
                        child: Text("22:30"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1380",
                        child: Text("23:00"),
                      ),
                      DropdownMenuItem<String>(
                        value: "1410",
                        child: Text("23:30"),
                      ),
                    ]))
              ]),
            ])),

        //Fun Facts
        Container(
            height: 40,
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Fun Fact",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ])),
        Container(
            height: 40,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    funFactLine1,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ])),
        Container(
            height: 40,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    funFactLine2,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ])),

        //Widgets
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
          height: 150,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.timeline,
                        size: 36,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/stats');
                      },
                    ))
              ],
            ),
            // Column(
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: Colors.white.withOpacity(0.1),
            //       ),
            //       child : IconButton (
            //         icon : const Icon(
            //           Icons.lightbulb,
            //           size : 36,
            //           color : Colors.blue,
            //         ),
            //         onPressed: () {},
            //       )
            //     )
            //   ],
            // ),
            // Column(
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15),
            //         color: Colors.white.withOpacity(0.1),
            //       ),
            //       child : IconButton (
            //         icon : const Icon(
            //           Icons.settings,
            //           size : 36,
            //           color : Colors.blue,
            //         ),
            //         onPressed: () {},
            //       )
            //     )
            //   ],
            // ),
          ]),
        ),
      ]),
    );
  }
}
