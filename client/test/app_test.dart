import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sleepapp/main.dart';
import 'package:sleepapp/pages/register.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text("Login"), findsOneWidget);
    expect(find.text("Don't have an account? Create one"), findsOneWidget);
  });

  testWidgets('Register Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Don't have an account? Create one"));
    await tester.pump();

    // Verify that our counter starts at 0.
    // expect(find.text("Create an account to make and view your sleep entries."),
    //     findsOneWidget);
    expect(find.text("Go back to Login"), findsOneWidget);
  });
}
