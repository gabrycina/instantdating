import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instant_dating/screens/welcome_screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:instant_dating/utilities/BottomNavigationBarController.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' as JSON;
//
//import 'package:instant_dating/utilities/facebook_user.dart';

class UserAccount {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
//  final _auth = FirebaseAuth.instance;
  final fbLogin = FacebookLogin();
  bool isLoading = false;

//  Future<void> login(BuildContext context, String email, String password) async {
//    try {
//      AuthResult user = await _auth.signInWithEmailAndPassword(
//          email: email, password: password);
//
//      if (user != null)
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//            builder: (context) => HomeScreen(
//              user: user,
//              type: 'email',
//            ),
//          ),
//        );
//    } catch (e) {
//      print(e);
//    }
//  }

//  Future<void> logout(BuildContext context) async {
//    await _auth.signOut();
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) => WelcomeScreen(),
//      ),
//    );
//  }

//  facebookLogin(BuildContext context) async {
//    final result = await fbLogin.logInWithReadPermissions(['email']);
//
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final token = result.accessToken.token;
//        final graphResponse = await http.get(
//            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
//        final profile = JSON.jsonDecode(graphResponse.body);
//        final facebookUser = ConvertUserFacebook(profile);
//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(
//            builder: (context) => HomeScreen(
//              user: facebookUser,
//              type: 'facebook',
//            ),
//          ),
//        );
//        break;
//      case FacebookLoginStatus.cancelledByUser:
//        break;
//      case FacebookLoginStatus.error:
//        break;
//    }
//  }

//  facebookLogout(BuildContext context) {
//    fbLogin.logOut();
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//        builder: (context) => WelcomeScreen(),
//      ),
//    );
//  }

  Future<void> googleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser != null)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarController(
              loggedUser: googleUser
            )
          ),
        );
    } catch (e) {
      print(e);
    }
  }

  Future<void> googleLogout(BuildContext context) async {
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
