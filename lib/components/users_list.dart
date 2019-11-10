import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant_dating/components/gradient_opacity.dart';
import 'package:instant_dating/screens/VisitedUserScreen/visited_user_screen.dart';
import 'package:instant_dating/services/user_repository.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:provider/provider.dart';

final _firestore = Firestore.instance;

class UsersList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userEmail = Provider.of<UserRepository>(context).userEmail;
    var userUid = Provider.of<UserRepository>(context).userUid;

    SizeConfig().init(context);
    UserRepository userRepository = UserRepository();

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.purple[100],
            ),
          );

        final usersDocs = snapshot.data.documents;
        List<Padding> usersDocsDecoded = [];
        for (var userInfo in usersDocs) {
          if (userInfo.data['id'] != userUid) {
            var receiverUserEmail = userInfo.data['email'];
            var receiverUserImage = userInfo.data['imageUrl'];
            var receiverUserUid = userInfo.data['uid'];
            var receiverUserNickname = userInfo.data['nickname'];
            var receiverUserAge = userInfo.data['age'];
            var receiverUserBio = userInfo.data['bio'];
            // var userLatitude = userInfo.data['position'].latitude;
            // var userLongitude = userInfo.data['position'].longitude;

            usersDocsDecoded.add(
              Padding(
                padding: EdgeInsets.only(bottom: 1.5),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    //image
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.horizontal * 1, vertical: 5),
                      child: Hero(
                        tag: receiverUserEmail,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: receiverUserImage,
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
                                receiverUserImage: receiverUserImage,
                                receiverUserEmail: receiverUserEmail,
                                receiverUserUid: receiverUserUid,
                                receiverUserNickname: receiverUserNickname,
                                receiverUserAge: receiverUserAge,
                                receiverUserBio: receiverUserBio,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: receiverUserUid,
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
                          Text(
                            '$receiverUserNickname, $receiverUserAge',
                            style: TextStyle(
                              fontSize: SizeConfig.horizontal * 4,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  await userRepository.sendPoke(
                                      receiverUserEmail, userEmail, userUid);
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Poke inviato'),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 8.0, top: 3.0),
                                        child: Text(
                                          'INVIA POKE',
                                          style: TextStyle(
                                            // fontSize: SizeConfig.horizontal * 3,
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
        }

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
      },
    );
  }
}
