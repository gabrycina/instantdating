import 'package:flutter/material.dart';
import 'package:instant_dating/screens/pokes_screen.dart';
import 'package:instant_dating/screens/user_screen.dart';
import 'package:instant_dating/utilities/profile_data_manager.dart';
import 'package:instant_dating/components/devices_location_list.dart';
import 'package:instant_dating/utilities/user_account.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:instant_dating/utilities/notification_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user});

  static final id = 'home_screen';
  final user;
//  final String type;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileDataManager profileDataManager = ProfileDataManager();

  var loggedUser;
  String accountName;
  bool isLoading = false;

  void setupUser() async {
    setState(() {
      isLoading = true;
    });

    loggedUser = widget.user;
    accountName = loggedUser.email;
    await profileDataManager.isNewUserAndSetup(loggedUser);
    await profileDataManager.listenCurrentUserLocation(accountName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setupUser();
    NotificationHandler().setup(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    profileDataManager.listenCurrentUserLocation("stop");
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
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
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
