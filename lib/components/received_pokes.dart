import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant_dating/screens/PokesScreen/components/pokes_button.dart';
import 'package:instant_dating/services/size_config.dart';

//TODO: add GestureDetector on CircleAvatar
import 'package:instant_dating/screens/VisitedUserScreen/visited_user_screen.dart';

final _firestore = Firestore.instance;

class ReceivedPokes extends StatelessWidget {
  ReceivedPokes({this.accountName});

  final String accountName;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        List<Card> usersDocsDecoded = [];

        for (var receivedPoke in receivedPokes) {
          var now = DateTime.now();
          Timestamp pokeSentAtTimestamp = receivedPoke.data['time'];

          //Converts Timestamp to DateTime and then calculates the difference
          DateTime pokeSentAtDateTime = DateTime.fromMillisecondsSinceEpoch(
              pokeSentAtTimestamp.millisecondsSinceEpoch);
          var diff = now.difference(pokeSentAtDateTime);
          if (diff.inMinutes <= 15) {
//            var senderEmail = receivedPoke.data['sender'];
//            var senderLatitude = receivedPoke.data['position'].latitude;
//            var senderLongitude = receivedPoke.data['position'].longitude;
            var senderImage = receivedPoke.data['image'];

            usersDocsDecoded.add(
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: senderImage,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.vertical * 4.5),
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(senderImage),
                                    radius: SizeConfig.horizontal * 8,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.computer,
                                        color: Colors.black,
                                        size: SizeConfig.horizontal * 3.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Christian Arduino',
                            style: TextStyle(
                              fontSize: SizeConfig.horizontal * 4.3,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Inviato 13min fa',
                            style: TextStyle(
                              fontSize: SizeConfig.horizontal * 3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: PokeButton(
                            backgroundColor: Colors.green,
                            icon: Icons.check,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: PokeButton(
                            backgroundColor: Color(0xFFFE3C72),
                            icon: Icons.close,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }

        return Padding(
          padding: EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.84,
            physics: ScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            children: usersDocsDecoded,
          ),
        );
      },
    );
  }
}
