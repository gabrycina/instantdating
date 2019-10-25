import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/services/notification_handler.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;
  final _firestore = Firestore.instance;

  //TODO:Review Shared Preferences thing (Saving data locally)
  SharedPreferences prefs;

  UserRepository();

  UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }


  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setupUser();
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      setupUser();
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }

  }

  Future signOut() async {
    listenCurrentUserLocation("stop");
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> isNewUserAndSetup(FirebaseUser user) async {
    prefs = await SharedPreferences.getInstance();

    if (user != null) {
      // Check is already sign up
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .getDocuments();

      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        // Create user data into the server if is a new user
        _firestore
            .collection('users')
            .document(user.uid)
            .setData({
          'id': user.uid,
          'email' : user.email,
          'lastPosition': GeoPoint(0, 0), //Starts from the Null island!
          'token': await NotificationHandler().getToken(),
          'bio' : '',
          'imageUrl' : 'https://images.unsplash.com/photo-1552162864-987ac51d1177?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
          'nickname' : '',
          'subInterests' : '', //This should be a list of interests titles :)
        });

        // Write data to local
        //TODO:Make Login persistent
        await prefs.setString('email', user.email);
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


  Future<void> listenCurrentUserLocation(String uid) async {
    var location = new Location();

    DocumentReference docRef =
        _firestore.collection('users').document(uid);

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

    if (uid == "stop") {
      // user navigated away!
      dataSub.cancel();
      print("Location Stream subscription stopped");
    }
  }


  Future<void> sendPoke(String receiverUserEmail, FirebaseUser user) async {
    if (user != null) {
      DocumentSnapshot loggedUserDocRef = await _firestore
        .collection('users')
        .document(user.uid)
        .get();

      //Hashes the timestamp to generate an unique id for the request
      String reqId = DateTime.now().hashCode.toString();

      //Adds the request to the database
      _firestore
          .collection('requests')
          .document(reqId)
          .setData({
        'id' : reqId,
        'sender': user.email,
        'receiver' : receiverUserEmail,
        'sentFrom': loggedUserDocRef.data['lastPosition'],  //Actual position of the sender
        'sentAt': DateTime.now(),
        'state' : 'pending',  //Default state is 'pending'
      });

    } else {
      print('Error loggedUser = null');
    }
  }

  void setupUser() async {
    await isNewUserAndSetup(_user);
    await listenCurrentUserLocation(_user.uid);
  }
}
