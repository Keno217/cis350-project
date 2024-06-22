// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleepapp/pages/register.dart';

void main() {
  testWidgets('Register Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home:Register()));

    //sign in button
    var button = find.text("Create Account");

    //sign in with no password
    final username = find.ancestor(
      of: find.text('Username'),
      matching: find.byType(TextField)
    );

    await tester.enterText(username, "TestAcc");
    expect(find.text("TestAcc"), findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(find.text("Password must be at least 3 characters"), findsOneWidget);
  });
}
