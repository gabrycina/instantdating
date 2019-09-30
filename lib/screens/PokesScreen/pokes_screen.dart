import 'package:flutter/material.dart';
import 'package:instant_dating/components/received_pokes.dart';

class PokesScreen extends StatefulWidget {
  PokesScreen({this.user, this.key});

  static final id = 'pokes_screen';
  final Key key;
  final user;

  @override
  _PokesScreenState createState() => _PokesScreenState();
}

class _PokesScreenState extends State<PokesScreen> {
  var loggedUser;
  String accountName;

  @override
  void initState() {
    super.initState();
    loggedUser = widget.user;
    accountName = loggedUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            ReceivedPokes(
              accountName: accountName,
            ),
          ],
        ),
      ),
    );
  }
}
