import 'package:flutter/material.dart';
import 'package:instant_dating/utilities/profile_data_manager.dart';
import 'package:instant_dating/utilities/notification_handler.dart';
import 'package:instant_dating/screens/home_screen.dart';
import 'package:instant_dating/screens/user_screen.dart';
import 'package:instant_dating/screens/pokes_screen.dart';
import 'package:instant_dating/utilities/user_account.dart';

class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController({this.loggedUser});

  final loggedUser;

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState extends State<BottomNavigationBarController> {
  var loggedUser;
  List<Widget> pages;
  ProfileDataManager profileDataManager = ProfileDataManager();
  String accountName;
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedUser = widget.loggedUser;
    setupUser();
    pages = [
      PokesScreen(
        key: PageStorageKey('pokes_screen'),
        user: loggedUser,
      ),
      HomeScreen(
        key: PageStorageKey('home_screen'),
        user: loggedUser,
      ),
      UserScreen(
        key: PageStorageKey('user_screen'),
        user: loggedUser,
      ),
    ];
    NotificationHandler().setup(context);
  }

  @override
  void dispose() {
    super.dispose();
    profileDataManager.listenCurrentUserLocation("stop");
  }

  void setupUser() async {
    var accountName = loggedUser.email;
    await profileDataManager.isNewUserAndSetup(loggedUser);
    await profileDataManager.listenCurrentUserLocation(accountName);
  }

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            title: Text('Pokes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Instant Dating'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
//                  switch (widget.type) {
//                    case 'google':
                await UserAccount().googleLogout(context);
//                      break;
//                    case 'facebook':
//                      UserAccount().facebookLogout(context);
//                      break;
//                    case 'email':
//                      UserAccount().logout(context);
//                  }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
