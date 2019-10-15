import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/screens/welcome_screen.dart';
import 'package:instant_dating/services/notification_handler.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'BottomNavigationBarController.dart';
import 'user_account.dart';

class ProfileDataManager {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _firestore = Firestore.instance;
  SharedPreferences prefs;


  Future<void> handleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if (googleUser != null){
        UserAccount userAccount = UserAccount(email: googleUser.email, id: googleUser.id);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BottomNavigationBarController(loggedUser: userAccount)),
        );
      }
    } catch (e) {
      //TODO: Handle Errors
      print(e);
    }
  }


  Future<void> handleLogout(BuildContext context) async {
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }


  Future<void> isNewUserAndSetup(UserAccount loggedUser) async {
    prefs = await SharedPreferences.getInstance();

    if (loggedUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('id', isEqualTo: loggedUser.id)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        // Create user data into the server if is a new user
        _firestore
            .collection('users')
            .document(loggedUser.id)
            .setData({
          'id': loggedUser.id,
          'email' : loggedUser.email,
          'lastPosition': GeoPoint(0, 0), //Starts from the Null island!
          'token': await NotificationHandler().getToken(),
          'bio' : '',
          'imageUrl' : 'https://images.unsplash.com/photo-1552162864-987ac51d1177?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
          'nickname' : '',
          'subInterests' : '', //This should be a list of interests titles :)
        });

        // Write data to local
        //TODO:Make Login persistent
        await prefs.setString('email', loggedUser.email);
        await prefs.setString('position', GeoPoint(0, 0).toString());
        await prefs.setString('token', await NotificationHandler().getToken());

        //TODO: Insert Image, let it set up by the user
        //await prefs.setString('profileImage', loggedUser.photoUrl);
      } else {
        // Write data to local
        //TODO:Make Login persistent
        await prefs.setString('email', documents[0]['email']);
        await prefs.setString('lastPosition', documents[0]['lastPosition'].toString());
        await prefs.setString('token', await documents[0]['token']);

        //TODO: Insert Image, let it set up by the user
        //await prefs.setString('profileImage', documents[0]['profileImage']);
      }
      Fluttertoast.showToast(msg: "Signed In!");
    } else {
      Fluttertoast.showToast(msg: "Sign In Failed :(");
    }
  }


  Future<void> listenCurrentUserLocation(String id) async {
    var location = new Location();

    DocumentReference docRef =
        _firestore.collection('users').document(id);

    // keep a reference to your stream subscription
    StreamSubscription<LocationData> dataSub;

    // convert the Future returned by getData() into a Stream
    // Update an existing document
    dataSub = location
        .onLocationChanged()
        .listen((LocationData currentLocation) async {
      await docRef.updateData({
        'lastPosition':
            GeoPoint(currentLocation.latitude, currentLocation.longitude),
      });
    });

    if (id == "stop") {
      // user navigated away!
      dataSub.cancel();
    } else {
      print("Location Stream subscription stopped");
    }
  }


  Future<void> sendPoke(String receiverUserEmail, UserAccount user) async {
    var loggedUser = user;
    if (loggedUser != null) {
      DocumentSnapshot loggedUserDocRef = await _firestore
        .collection('users')
        .document(loggedUser.id)
        .get();

      //Hashes the timestamp to generate an unique id for the request
      String reqId = DateTime.now().hashCode.toString();

      //Adds the request to the database
      _firestore
          .collection('requests')
          .document(reqId)
          .setData({
        'id' : reqId,
        'sender': loggedUser.email,
        'receiver' : receiverUserEmail,
        'sentFrom': loggedUserDocRef.data['lastPosition'],  //Actual position of the sender
        'sentAt': DateTime.now(),
        'state' : 'pending',  //Default state is 'pending'
      });

    } else {
      print('Error loggedUser = null');
    }
  }

}
