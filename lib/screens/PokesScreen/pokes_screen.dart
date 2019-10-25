import 'package:flutter/material.dart';
import 'package:instant_dating/components/received_pokes.dart';
import 'package:instant_dating/services/user_repository.dart';
import 'package:provider/provider.dart';

class PokesScreen extends StatefulWidget {
  PokesScreen({this.key});
  static final id = 'pokes_screen';
  final Key key;

  @override
  _PokesScreenState createState() => _PokesScreenState();
}

class _PokesScreenState extends State<PokesScreen> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserRepository>(context).user;
    return Scaffold(
      body: SafeArea(
        child: ReceivedPokes(
          accountEmail: user.email,
        ),
      ),
    );
  }
}
