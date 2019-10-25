import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:instant_dating/services/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:instant_dating/services/BottomNavigationBarController.dart';

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
      home: AppFirstPage(),
    );
  }
}

class AppFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
//            TODO: Create a decent SplashScreen
              return SplashScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
//            TODO: Create a decent Login Screen
              return LoginScreen();
            case Status.Authenticated:
              return BottomNavigationBarController();
          }
          //TODO: The following line is dev version only
          return Container();
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircularProgressIndicator(
        backgroundColor: Colors.purpleAccent,
      ),
    );
  }
}
