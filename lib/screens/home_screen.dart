import 'package:flutter/material.dart';
import 'package:instant_dating/components/devices_location_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user, this.key});

  static final id = 'home_screen';
  final Key key;
  final user;
//  final String type;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var loggedUser;
  String accountName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedUser = widget.user;
    accountName = loggedUser.email;
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: DevicesLocation(
                accountName: accountName,
                user: loggedUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
