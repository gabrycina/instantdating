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

        for (var poke in receivedPokes) {
          var senderUser = poke.data['sender'];
          var senderLatitude = poke.data['position'].latitude;
          var senderLongitude = poke.data['position'].longitude;

          usersDocsDecoded.add(
            ListTile(
              leading: Icon(Icons.accessible_forward),
              title: Text('Poke sent by $senderUser'),
              subtitle: Text('From: $senderLatitude - $senderLongitude'),
              trailing: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.accessible),
                    onPressed: () {},
                  )
                ],
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
