// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sleepapp/pages/LandingPage.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home:LandingPage()));

    //check non varied text
    expect(find.text("Average Sleep : "), findsOneWidget);
    expect(find.text("Total Sleep : "), findsOneWidget);
    expect(find.text("Start Time : "), findsOneWidget);
    expect(find.text("End Time : "), findsOneWidget);

    //no username
    expect(find.text("Welcome, "), findsOneWidget);

    //find buttons
    var button = find.byIcon(Icons.timeline);
    expect(button, findsOneWidget);

    var back = find.byIcon(Icons.arrow_back);
    expect(back, findsOneWidget);

    var add = find.text("Add");
    expect(add, findsOneWidget);

    //find dropdowns
    //final startDropdown = find.byKey(const ValueKey('dropdown'));


  });
}
