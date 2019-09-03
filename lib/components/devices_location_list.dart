import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _firestore = Firestore.instance;

class DevicesLocation extends StatelessWidget {
  DevicesLocation({this.accountName, this. user});

  final String accountName;
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('devicesLocation').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple[100],
            ),
          );

        final usersDocs = snapshot.data.documents;
        List<ListTile> usersDocsDecoded = [];

        for (var userInfo in usersDocs) {
          if (userInfo.data['accountName'] != accountName) {
            var userEmail = userInfo.data['accountName'];
            var userLatitude = userInfo.data['position'].latitude;
            var userLongitude = userInfo.data['position'].longitude;

            usersDocsDecoded.add(
              ListTile(
                leading: Icon(Icons.phone_iphone),
                title: Text(
                    '$userEmail, Lat: $userLatitude , Long: $userLongitude'),
                trailing: GestureDetector(
                  child: Icon(Icons.add_circle_outline),
                  onTap: () async {
                    await sendPoke(userEmail, user);
                  },
                ),
              ),
            );
          }
        }

        return ListView(
          children: usersDocsDecoded,
        );
      },
    );
  }

  Future<void> sendPoke(String receiverEmail, dynamic user) async {
    DocumentSnapshot docRef = await _firestore.collection('devicesLocation').document(user.email).get();

    print(user);
    if (user != null) {
      _firestore
          .collection('devicesLocation')
          .document(receiverEmail)
          .collection('pokes')
          .add({
        'sender': user.email,
        'position': docRef.data['position'],
      });
    } else {
      Fluttertoast.showToast(msg: 'You Need to Login First');
    }
  }
}
