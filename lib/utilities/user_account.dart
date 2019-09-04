import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instant_dating/screens/home_screen.dart';
import 'package:instant_dating/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAccount {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  bool isLoading = false;

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: user,
            ),
          ),
        );
    } catch (e) {
      print(e);
    }
  }

  Future<void>logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
    //TODO: Remove debug Prints
    print('email sign out');
  }

  Future<void>googleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      if (googleUser != null)
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

  Future<void> googleLogout(BuildContext context) async {
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
