import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ReceivedPokes extends StatelessWidget {
  ReceivedPokes({this.accountName});

  final String accountName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('devicesLocation')
          .document(accountName)
          .collection('pokes')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple[100],
            ),
          );

        final receivedPokes = snapshot.data.documents;
        List<ListTile> usersDocsDecoded = [];

        for (var receivedPoke in receivedPokes) {
          var senderEmail = receivedPoke.data['sender'];
          var senderLatitude = receivedPoke.data['position'].latitude;
          var senderLongitude = receivedPoke.data['position'].longitude;

          usersDocsDecoded.add(
            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text(
                  '$senderEmail, Lat: $senderLatitude , Long: $senderLongitude'),
              trailing: GestureDetector(
                child: Icon(Icons.check),
                //TODO: implement poke reject/acccept function
                onTap: () {},
              ),
            ),
          );
        }

        return ListView(
          children: usersDocsDecoded,
        );
      },
    );
  }
}
