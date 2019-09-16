import 'package:flutter/material.dart';
import 'package:instant_dating/utilities/profile_data_manager.dart';

class PokesScreen extends StatefulWidget {
  PokesScreen({this.user});

  static final id = 'pokes_screen';
  final user;
//  final String type;

  @override
  _PokesScreenState createState() => _PokesScreenState();
}

class _PokesScreenState extends State<PokesScreen> {
  ProfileDataManager profileDataManager = ProfileDataManager();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    profileDataManager.listenCurrentUserLocation("stop");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Instant Dating(Prototype)'),
      ),
      body: Container(),
    );
  }
}
