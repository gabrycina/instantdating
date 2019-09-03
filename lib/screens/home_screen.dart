import 'package:flutter/material.dart';
import 'package:instant_dating/utilities/profile_data_manager.dart';
import 'package:instant_dating/components/devices_location_list.dart';
import 'package:instant_dating/utilities/user_account.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user});

  static final id = 'home_screen';
  final user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileDataManager profileDataManager = ProfileDataManager();

  var loggedUser;
  String accountName;

  void setupUser() async {
    loggedUser = await profileDataManager.getCurrentUser(widget.user);
    accountName = loggedUser.email;
    await profileDataManager.isNewUserAndSetup(loggedUser);
    await profileDataManager.listenCurrentUserLocation(accountName);
  }

  @override
  void initState() {
    super.initState();
    setupUser();
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
              onPressed: () => widget.user != null
                  ? UserAccount().googleLogout(context)
                  : UserAccount().logout(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: DevicesLocation(
              accountName: accountName,
              user: loggedUser,
            ),
          ),
        ],
      ),
    );
  }
}
