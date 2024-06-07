import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/LandingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Landing PaPge",
      home: LandingPage()
    );
  }
}