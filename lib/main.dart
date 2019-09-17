import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
//import 'screens/login_screen.dart';
//import 'screens/registration_screen.dart';
//import 'screens/home_screen.dart';
//import 'package:instant_dating/screens/pokes_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
//      initialRoute: WelcomeScreen.id,
//      routes: {
//      WelcomeScreen.id: (context) => WelcomeScreen(),
//      RegistrationScreen.id: (context) => RegistrationScreen(),
//      LoginScreen.id: (context) => LoginScreen(),
//      HomeScreen.id: (context) => HomeScreen(),
//      PokesScreen.id: (context) => PokesScreen(),
//    },
    );
  }
}
