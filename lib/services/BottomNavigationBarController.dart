import 'package:flutter/material.dart';
import 'package:instant_dating/screens/HomeScreen/home_screen.dart';
import 'package:instant_dating/services/profile_data_manager.dart';
import 'package:instant_dating/services/notification_handler.dart';
import 'package:instant_dating/screens/account_screen.dart';
import 'package:instant_dating/screens/PokesScreen/pokes_screen.dart';

class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController({this.loggedUser});

  final loggedUser;

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
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
      AccountScreen(
        key: PageStorageKey('account_screen'),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active,
              color:
                  _selectedIndex == 0 ? Color(0xFFFF655B) : Color(0xFF686868),
            ),
            title: Text(
              'Pokes',
              style: TextStyle(
                color:
                    _selectedIndex == 0 ? Color(0xFFFF655B) : Color(0xFF686868),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color:
                  _selectedIndex == 1 ? Color(0xFFFF655B) : Color(0xFF686868),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color:
                    _selectedIndex == 1 ? Color(0xFFFF655B) : Color(0xFF686868),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color:
                  _selectedIndex == 2 ? Color(0xFFFF655B) : Color(0xFF686868),
            ),
            title: Text(
              'Account',
              style: TextStyle(
                color:
                    _selectedIndex == 2 ? Color(0xFFFF655B) : Color(0xFF686868),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
        body: PageStorage(
          child: pages[_selectedIndex],
          bucket: bucket,
        ),
      ),
    );
  }
}
