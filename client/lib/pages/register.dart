import 'package:flutter/material.dart';
import 'package:sleepapp/pages/LandingPage.dart';
import 'package:sleepapp/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width),
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
                        SizedBox(
                            height:
                                0), // Reduced height to bring the text closer
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
                            // handle account creation later
                            String username = _usernameController.text;
                            String password = _passwordController.text;
                            print('Username: $username');
                            print('Password: $password');
                            await createUser(username, password);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage()),
                            );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
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

Future<http.Response> createUser(String name, String pass) {
  String server = 'http://129.80.148.244:3001';

  return http.post(
    Uri.parse('$server/createUser'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
    }),
  );
}
