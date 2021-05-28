import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:warganetsoshum/auth.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Container(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text('\u{1F1EE}\u{1F1E9}'),
                  SizedBox(height: 4.0),
                  StreamBuilder(
                    stream: AuthService().user,
                    builder: (context, snapshot) {
                      return SignInButton(
                        Buttons.Google,
                        text: 'Masuk dengan Google',
                        onPressed: () => AuthService().signInWithGoogle(),
                      );
                    }
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'supported by Forum Ekonomi Berkarya Untuk Indonesia',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic
                    ),
                  )
                ],
              ),
            )
          )
        )
      )
    );
  }
}