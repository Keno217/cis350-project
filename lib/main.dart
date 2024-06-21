import 'package:flutter/material.dart';
import 'package:sleepapp/pages/register.dart';
import 'package:sleepapp/pages/login.dart';
import 'package:sleepapp/pages/landing_page.dart';
import 'package:sleepapp/pages/statistics_page.dart';

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
        home: const Login(),
        //routing list of pages.  just add another line for different pages
        routes: {
          '/register': (context) => Register(),
          '/login': (context) => const Login(),
          '/landing': (context) => const LandingPage(),
          '/stats': (context) => const StatisticsPage(),
        });
  }
}
