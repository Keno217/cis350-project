import 'package:flutter/material.dart';
import 'package:sleepapp/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // removes username and password text editor ensuring no mem. leaks
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(String username, String password) async {
    if (username.isEmpty) {
      _showErrorMessage('Username must be at least 1 character');
      return;
    }

    if (username.length > 12) {
      _showErrorMessage('Username must be less than 12 characters');
      return;
    }

    if (password.length < 3) {
      _showErrorMessage('Password must be at least 3 characters');
      return;
    }

    setState(() {
      // sign in icon becomes loading icon so client cant spam req
      _isLoading = true;
    });

    String server = 'http://129.80.148.244:3001'; // server from oracle on 24/7
    String hashedPassword =
        hashPassword(password); // hash password before it is sent over the net

    var response = await http.post(
      Uri.parse('$server/loginUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': username,
        'pass': hashedPassword,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      _showErrorMessage('Login Successful.');
      globalUsername = username; // set username we will use in other files
      Navigator.pushNamed(context, '/landing');
    } else {
      _showErrorMessage('Invalid Credentials.');
    }
  }

  void _showErrorMessage(String message) {
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
                  const Align(
                    alignment: Alignment(0, -0.5),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        _isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.cyan),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  String username = _usernameController.text;
                                  String password = _passwordController.text;
                                  await loginUser(username,
                                      password); // http post with user and password
                                },
                                child: const Text('Sign In',
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
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Don't have an account? Create one",
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
