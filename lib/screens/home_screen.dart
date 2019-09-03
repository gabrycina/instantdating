import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instant_dating/screens/welcome_screen.dart';
import 'package:location/location.dart';
import 'package:instant_dating/components/devices_location_list.dart';

final _firestore = Firestore.instance;

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user});

  static final id = 'home_screen';
  final user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  var loggedUser;
  String accountName;

  void getCurrentUserAndLocation() async {
    bool isGoogle = widget.user != null;
    try {
      if (isGoogle) {
        loggedUser = widget.user;
        accountName = loggedUser.email;
      } else {
        var user = await _auth.currentUser();
        if (user != null) {
          loggedUser = user;
          accountName = loggedUser.email;
        }
      }
    } catch (e) {
      print(e);
    }

    var location = new Location();

    // Update an existing document (the first time it creates the document)
    DocumentReference docRef =
        _firestore.collection('devicesLocation').document(accountName);
    docRef.setData({
      'accountName': accountName,
      //starts in the Null Island :0
      'position': GeoPoint(0, 0),
    });

    location.onLocationChanged().listen((LocationData currentLocation) async {
      await docRef.updateData({
        'position':
            GeoPoint(currentLocation.latitude, currentLocation.longitude),
      });

      print(currentLocation.latitude);
      print(currentLocation.longitude);
    });
  }

  _googleLogout() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    print('google sign out');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }

  _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
    print('email sign out');
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserAndLocation();
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
              onPressed: () =>
                  widget.user != null ? _googleLogout() : _logout(),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: DevicesLocation(
              accountName: accountName,
            ),
          ),
        ],
      ),
    );
  }
}
