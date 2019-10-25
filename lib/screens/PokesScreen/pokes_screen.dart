import 'package:flutter/material.dart';
import 'package:instant_dating/components/received_pokes.dart';

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
    return Scaffold(
      body: SafeArea(
        child: ReceivedPokes(),
      ),
    );
  }
}
