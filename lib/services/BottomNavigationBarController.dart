import 'package:flutter/material.dart';
import 'package:instant_dating/screens/AccountScreen/account_screen.dart';
import 'package:instant_dating/screens/HomeScreen/home_screen.dart';
import 'package:instant_dating/services/notification_handler.dart';
import 'package:instant_dating/screens/PokesScreen/pokes_screen.dart';
import 'package:instant_dating/screens/AcceptedRequestsScreen/accepted_requests_screen.dart';

class BottomNavigationBarController extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final PageStorageBucket bucket = PageStorageBucket();

  List<Widget> pages;
  String accountName;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    pages = [
      PokesScreen(
        key: PageStorageKey('pokes_screen'),
      ),
      AcceptedRequestsScreen(
        key: PageStorageKey('accepted_requests_screen'),
      ),
      HomeScreen(
        key: PageStorageKey('home_screen'),
      ),
      AccountScreen(
        key: PageStorageKey('account_screen'),
      ),
    ];
    NotificationHandler().setup(context);
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
              Icons.beenhere,
              color:
                  _selectedIndex == 1 ? Color(0xFFFF655B) : Color(0xFF686868),
              size: 22,
            ),
            title: Text(
              'Accepted',
              style: TextStyle(
                color:
                    _selectedIndex == 1 ? Color(0xFFFF655B) : Color(0xFF686868),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color:
                  _selectedIndex == 2 ? Color(0xFFFF655B) : Color(0xFF686868),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color:
                    _selectedIndex == 2 ? Color(0xFFFF655B) : Color(0xFF686868),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color:
                  _selectedIndex == 3 ? Color(0xFFFF655B) : Color(0xFF686868),
            ),
            title: Text(
              'Account',
              style: TextStyle(
                color:
                    _selectedIndex == 3 ? Color(0xFFFF655B) : Color(0xFF686868),
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
