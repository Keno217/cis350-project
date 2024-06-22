// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sleepapp/main.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
    //Looks for Text
    expect(find.text("Login"), findsOneWidget);
    expect(find.text("Don't have an account? Create one"), findsOneWidget);

    //sign in button
    var button = find.text("Sign In");
    expect(button, findsOneWidget);

    //sign in with no password
    final username = find.ancestor(
      of: find.text('Username'),
      matching: find.byType(TextField)
    );
    await tester.enterText(username, "TestAcc");
    expect(find.text("TestAcc"), findsOneWidget);

  });
}
