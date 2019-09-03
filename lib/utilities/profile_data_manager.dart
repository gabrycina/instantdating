import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class ProfileDataManager{
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  void isNewUserAndSetup(dynamic loggedUser) async {
    if (loggedUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await _firestore.collection(
          'devicesLocation').where('accountName', isEqualTo: loggedUser.email).getDocuments();
      final List <DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        _firestore.collection('devicesLocation')
            .document(loggedUser.email)
            .setData({
          'accountName': loggedUser.email,
          'position': GeoPoint(0, 0),
        });
      }
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

  void listenCurrentUserLocation(String accountName) async {
    var location = new Location();

    // Update an existing document
    DocumentReference docRef =
    _firestore.collection('devicesLocation').document(accountName);

    location.onLocationChanged().listen((LocationData currentLocation) async {
      await docRef.updateData({
        'position': GeoPoint(currentLocation.latitude, currentLocation.longitude),
      });

      //TODO: Remove Debug Prints
      print(currentLocation.latitude);
      print(currentLocation.longitude);
    });
  }

}