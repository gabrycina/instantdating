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
          var senderImage = receivedPoke.data['image'];

          usersDocsDecoded.add(
            ListTile(
              leading: senderImage == null
                  ? Icon(Icons.notifications_active)
                  : CircleAvatar(
                      backgroundImage: NetworkImage(senderImage),
                    ),
              title: Text('$senderEmail'),
              subtitle: Text('Lat: $senderLatitude , Long: $senderLongitude'),
              trailing: GestureDetector(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.check),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
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
