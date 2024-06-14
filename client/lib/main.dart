import 'package:flutter/material.dart';
import 'package:sleepapp/pages/register.dart';
import 'package:sleepapp/pages/login.dart';
import 'package:sleepapp/pages/LandingPage.dart';
import 'package:sleepapp/pages/StatisticsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login",
        home: Login(),
        //routing list of pages.  just add another line for different pages
        routes: {
          '/register': (context) => const Register(),
          '/login': (context) => const Login(),
          '/landing': (context) => const LandingPage(),
          '/stats': (context) => const StatisticsPage(),
        });
  }
}
