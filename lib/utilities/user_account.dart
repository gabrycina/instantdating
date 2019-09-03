import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instant_dating/screens/home_screen.dart';
import 'package:instant_dating/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAccount {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  login(BuildContext context, String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) Navigator.pushNamed(context, HomeScreen.id);
    } catch (e) {
      print(e);
    }
  }

  logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
    print('email sign out');
  }

  googleLogin(BuildContext context) async {
    try {
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

  googleLogout(BuildContext context) async {
    await _googleSignIn.signOut();
    print('google sign out');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
