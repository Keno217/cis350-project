import 'package:sleepapp/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment(0, -0.5),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Create your account',
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.cyan,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Create an account to make and view your sleep entries.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            // account creation
                            String username = _usernameController.text;
                            String password = _passwordController.text;
                            if (username.isEmpty) {
                              _showErrorMessage(context,
                                  'Username must be at least 1 character');
                              return;
                            }

                            if (username.length > 12) {
                              _showErrorMessage(context,
                                  'Username must be less than 12 characters');
                              return;
                            }

                            if (password.length < 3) {
                              _showErrorMessage(context,
                                  'Password must be at least 3 characters');
                              return;
                            }

                            if (password.length > 12) {
                              _showErrorMessage(context,
                                  'Password must be less than 12 characters');
                              return;
                            }

                            int response =
                                await createUser(username, password, context);

                            if (response == 0) {
                              _showErrorMessage(
                                  context, 'Server connection error');
                              return;
                            }

                            if (response == 1) {
                              _showErrorMessage(context, 'Account Created');
                              return;
                            }

                            if (response == 2) {
                              _showErrorMessage(context, 'User already exists');
                              return;
                            }
                          },
                          child: Text('Create Account',
                              style: TextStyle(color: Colors.cyan)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Go back to Login",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<int> createUser(
    // creates a user, returns an int for a corresponding message
    String username,
    String password,
    BuildContext context) async {
  String server = 'http://129.80.148.244:3001';

  String hashedPassword = hashPassword(password);

  var response = await http.post(
    Uri.parse('$server/createUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user': username,
      'pass': hashedPassword,
    }),
  );

  if (response.statusCode == 201) {
    Navigator.pushNamed(context, '/login');
    return 1;
  }

  if (response.statusCode == 409) {
    return 2;
  }
  return 0;
}
