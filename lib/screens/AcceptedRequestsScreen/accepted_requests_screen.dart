import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant_dating/screens/VisitedUserScreen/visited_user_screen.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:instant_dating/services/user_account.dart';
import 'package:instant_dating/components/gradient_opacity.dart';

final _firestore = Firestore.instance;

class AcceptedRequestsScreen extends StatefulWidget {
  AcceptedRequestsScreen({this.key, this.user});

  static final id = 'accepted_requests_screen';
  final key;
  final UserAccount user;

  @override
  _AcceptedRequestsScreenState createState() => _AcceptedRequestsScreenState();
}

class _AcceptedRequestsScreenState extends State<AcceptedRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    var loggedUser = widget.user;
    SizeConfig().init(context);

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('requests')
          .where('receiver', isEqualTo: loggedUser.email)
          .where('state', isEqualTo: 'accepted')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple[100],
            ),
          );

        final requestsDocs = snapshot.data.documents;
        List<Padding> usersDocsDecoded = [];
        for (var requestDoc in requestsDocs) {
          var senderEmail = requestDoc.data['sender'];
          var senderImageUrl = 'https://images.unsplash.com/photo-1552162864-987ac51d1177?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80';
          // var userLatitude = userInfo.data['position'].latitude;
          // var userLongitude = userInfo.data['position'].longitude;
          //TODO: User's image set up
          usersDocsDecoded.add(
            Padding(
              padding: EdgeInsets.only(bottom: 1.5),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.horizontal * 1, vertical: 5),
                    child: Hero(
                      tag: senderEmail,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: senderImageUrl,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.horizontal * 1, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (cxt) => VisitedUser(
                              userImage: senderImageUrl,
                              //change with name and surname
                              userEmail: senderEmail,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'opacity$senderImageUrl',
                        child: GradientOpacity(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.horizontal * 2, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Christian, 18',
                            style: TextStyle(
                              fontSize: SizeConfig.horizontal * 4,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if(usersDocsDecoded.length > 0){
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 0.84,
              physics: ScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              children: usersDocsDecoded,
            ),
          );
        } else {
          return Center(
            child: Text(
              'Non hai accettato ancora nessuna richiesta'
            ),
          );
        }

      },
    );
  }
}
