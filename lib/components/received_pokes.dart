import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:instant_dating/components/gradient_opacity.dart';
import 'package:instant_dating/screens/PokesScreen/components/pokes_button.dart';
import 'package:instant_dating/services/size_config.dart';

//TODO: add GestureDetector on CircleAvatar
import 'package:instant_dating/screens/VisitedUserScreen/visited_user_screen.dart';

final _firestore = Firestore.instance;

class ReceivedPokes extends StatefulWidget {
  ReceivedPokes({this.accountName});

  final String accountName;

  @override
  _ReceivedPokesState createState() => _ReceivedPokesState();
}

class _ReceivedPokesState extends State<ReceivedPokes>
    with TickerProviderStateMixin {
  int removeFromListIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('devicesLocation')
          .document(widget.accountName)
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
        List usersDocsDecoded = [];

        for (var receivedPoke in receivedPokes) {
          if(receivedPoke.documentID != 'receivedCounter'){
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
                senderImage,
              );
            }
          }else{
            removeFromListIndex++;
          }
        }

        if (usersDocsDecoded.length > 0) {
          return Stack(
            children: <Widget>[
              Positioned(
                top: SizeConfig.vertical * 50,
                left: SizeConfig.horizontal * 35,
                child: Text('Hai finito tutti i tuoi poke!'),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: EdgeInsets.only(top: SizeConfig.vertical * 5),
                height: SizeConfig.vertical * 77,
                child: TinderSwapCard(
                  totalNum: receivedPokes.length - removeFromListIndex,
                  stackNum: 3,
                  maxWidth: SizeConfig.horizontal * 95,
                  maxHeight: SizeConfig.vertical * 95,
                  minWidth: SizeConfig.horizontal * 90,
                  minHeight: SizeConfig.horizontal * 90,
                  cardBuilder: (context, index) => Card(
                    child: CachedNetworkImage(
                      imageUrl: usersDocsDecoded[index],
                      fit: BoxFit.cover,
                      imageBuilder: (context, image) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: image,
                                fit: BoxFit.cover,
                              ),),
                            ),
                            GradientOpacity(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 16.0),
                                      child: Text(
                                        'DAI UN\'OCCHIATA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: SizeConfig.horizontal * 3.5,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    if (orientation == CardSwipeOrientation.LEFT) {
                      //TODO: aggiungere funzione per swipe a sinistra
                    } else if (orientation == CardSwipeOrientation.RIGHT) {
                      //TODO: aggiungere funzione per swipe a destra
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('Nessun Poke ricevuto negli ultimi 15 minuti'),
          );
        }
      },
    );
  }
}

// Padding(
//             padding: EdgeInsets.all(8.0),
//             child: GridView.count(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//               childAspectRatio: 0.84,
//               physics: ScrollPhysics(), // to disable GridView's scrolling
//               shrinkWrap: true,
//               children: usersDocsDecoded,
//             ),
//           );
