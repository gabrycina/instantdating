import 'package:flutter/material.dart';
import 'package:instant_dating/components/received_pokes.dart';
import 'package:instant_dating/services/user_account.dart';

class PokesScreen extends StatefulWidget {
  PokesScreen({this.user, this.key});

  static final id = 'pokes_screen';
  final Key key;
  final UserAccount user;

  @override
  _PokesScreenState createState() => _PokesScreenState();
}

class _PokesScreenState extends State<PokesScreen> {
  var loggedUser;
  String accountEmail;

  @override
  void initState() {
    super.initState();
    loggedUser = widget.user;
    accountEmail = loggedUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReceivedPokes(
          accountEmail: accountEmail,
        ),
      ),
    );
  }
}
