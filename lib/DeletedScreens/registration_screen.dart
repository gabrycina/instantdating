//import 'package:flutter/material.dart';
//import 'package:instant_dating/constants.dart';
//import 'package:instant_dating/components/action_button.dart';
//import 'home_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//
//class RegistrationScreen extends StatefulWidget {
//  static final id = 'registration_screen';
//
//  @override
//  _RegistrationScreenState createState() => _RegistrationScreenState();
//}
//
//class _RegistrationScreenState extends State<RegistrationScreen> {
//  final _auth = FirebaseAuth.instance;
//  String email, password;
//  bool isLoading = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//        child: ModalProgressHUD(
//          inAsyncCall: isLoading,
//          child: Padding(
//            padding: const EdgeInsets.all(30.0),
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Image.asset(
//                  'images/logo.png',
//                  width: 150,
//                  height: 150,
//                ),
//                SizedBox(
//                  height: 48.0,
//                ),
//                TextField(
//                  keyboardType: TextInputType.emailAddress,
//                  maxLines: 1,
//                  onChanged: (value) {
//                    email = value;
//                  },
//                  decoration:
//                      kTextInputStyle.copyWith(hintText: 'Enter Your Email'),
//                ),
//                SizedBox(
//                  height: 8.0,
//                ),
//                TextField(
//                  obscureText: true,
//                  onChanged: (value) {
//                    password = value;
//                  },
//                  maxLines: 1,
//                  decoration:
//                      kTextInputStyle.copyWith(hintText: 'Enter Your Password'),
//                ),
//                SizedBox(
//                  height: 24.0,
//                ),
//                ActionButton(
//                  onTapAction: () async {
//                    setState(() {
//                      isLoading = true;
//                    });
//                    try {
//                      var newUser = await _auth.createUserWithEmailAndPassword(
//                          email: email, password: password);
//                      if (newUser != null)
//                        Navigator.pushNamed(context, HomeScreen.id);
//                    } catch (e) {
//                      print(e);
//                    }
//                    setState(() {
//                      isLoading = false;
//                    });
//                  },
//                  buttonText: 'Register',
//                  buttonColor: Colors.purple[800],
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
