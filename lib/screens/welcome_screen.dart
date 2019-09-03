import 'package:flutter/material.dart';
import 'package:instant_dating/components/action_button.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instant_dating/screens/home_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _login() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final googleUser = await _googleSignIn.signIn();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: googleUser,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                width: 150,
                height: 150,
              ),
              ActionButton(
                onTapAction: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                buttonColor: Colors.purple,
                buttonText: 'Login',
              ),
              ActionButton(
                onTapAction: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                buttonColor: Colors.purple[800],
                buttonText: 'Register',
              ),
              GoogleSignInButton(
                onPressed: () {
                  _login();
                },
                darkMode: true, // default: false
              ),
              FacebookSignInButton(
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
