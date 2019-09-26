import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFFEEEEEE),
        accentColor: Color(0xFFFF655B),
        disabledColor: Color(0xFFFF655B),
        fontFamily: 'Lato',
        textTheme: TextTheme(
          headline: TextStyle(
            color: Color(0xFF424242),
          ),
          title: TextStyle(
            color: Color(0xFF424242),
          ),
          body1: TextStyle(
            color: Color(0xFF424242),
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
