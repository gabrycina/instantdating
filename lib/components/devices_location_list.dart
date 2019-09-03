import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class DevicesLocation extends StatelessWidget {
  DevicesLocation({this.accountName});

  final String accountName;

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
}
