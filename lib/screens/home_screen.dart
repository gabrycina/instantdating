import 'package:flutter/material.dart';
import 'package:instant_dating/screens/pokes_screen.dart';
import 'package:instant_dating/screens/user_screen.dart';
import 'package:instant_dating/components/devices_location_list.dart';
import 'package:instant_dating/utilities/user_account.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Instant Dating(Prototype)'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
//                  switch (widget.type) {
//                    case 'google':
                  UserAccount().googleLogout(context);
//                      break;
//                    case 'facebook':
//                      UserAccount().facebookLogout(context);
//                      break;
//                    case 'email':
//                      UserAccount().logout(context);
//                  }
                }),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserScreen(user: widget.user),
              ),
            ),
            child: Icon(Icons.supervised_user_circle),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokesScreen(user: widget.user),
              ),
            ),
            child: Icon(Icons.sync),
          ),
        ],
      ),
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
