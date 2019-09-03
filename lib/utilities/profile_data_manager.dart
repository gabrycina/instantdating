import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class ProfileDataManager {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  SharedPreferences prefs;

  Future<void> isNewUserAndSetup(dynamic loggedUser) async {
    prefs = await SharedPreferences.getInstance();

    if (loggedUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await _firestore
          .collection('devicesLocation')
          .where('accountName', isEqualTo: loggedUser.email)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        _firestore
            .collection('devicesLocation')
            .document(loggedUser.email)
            .setData({
          'accountName': loggedUser.email,
          'position': GeoPoint(0, 0),
        });

        // Write data to local
        await prefs.setString('accountName', loggedUser.email);
        await prefs.setString('position', GeoPoint(0, 0).toString());
      } else {
        // Write data to local
        await prefs.setString('accountName', documents[0]['accountName']);
        await prefs.setString('position', documents[0]['position'].toString());
      }
      Fluttertoast.showToast(msg: "Sign in Succeded");
    } else {
      Fluttertoast.showToast(msg: "Sign In Failed");
    }
  }

  Future<dynamic> getCurrentUser(dynamic user) async {
    bool isGoogle = user != null;
    var loggedUser;
    try {
      if (isGoogle) {
        loggedUser = user;
      } else {
        var user = await _auth.currentUser();
        if (user != null) {
          loggedUser = user;
        }
      }
    } catch (e) {
      print(e);
    }
    return loggedUser;
  }

  Future<void> listenCurrentUserLocation(String accountName) async {
    var location = new Location();

    DocumentReference docRef =
        _firestore.collection('devicesLocation').document(accountName);

    // keep a reference to your stream subscription
    StreamSubscription<LocationData> dataSub;

    // convert the Future returned by getData() into a Stream
    // Update an existing document
    dataSub = location
        .onLocationChanged()
        .listen((LocationData currentLocation) async {
      await docRef.updateData({
        'position':
            GeoPoint(currentLocation.latitude, currentLocation.longitude),
      });
    });

    if (accountName == "stop") {
      // user navigated away!
      dataSub.cancel();
    } else {
      print("Location Stream subscription stopped");
    }
  }
}
