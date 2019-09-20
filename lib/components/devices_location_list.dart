import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant_dating/components/gradient_opacity.dart';
import 'package:instant_dating/screens/VisitedUserScreen/visited_user_screen.dart';
import 'package:instant_dating/services/profile_data_manager.dart';
import 'package:instant_dating/services/size_config.dart';

final _firestore = Firestore.instance;

class DevicesLocation extends StatelessWidget {
  DevicesLocation({this.accountName, this.user});

  final String accountName;
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ProfileDataManager profileDataManager = ProfileDataManager();

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
        List<Padding> usersDocsDecoded = [];
        for (var userInfo in usersDocs) {
          if (userInfo.data['accountName'] != accountName) {
            var userEmail = userInfo.data['accountName'];
            // var userLatitude = userInfo.data['position'].latitude;
            // var userLongitude = userInfo.data['position'].longitude;
            var userImage = userInfo.data['profileImage'];

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
                        tag: userEmail,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(userImage),
                              fit: BoxFit.cover,
                            ),
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
                                      userImage: userImage,
                                      //change with name and surname
                                      userEmail: userEmail,
                                    )),
                          );
                        },
                        child: GradientOpacity(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.horizontal * 2,
                                vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Christian, 18',
                                  style: TextStyle(
                                    fontSize: SizeConfig.horizontal * 4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                                // Text(
                                //   'Meno 1km di distanza',
                                //   style: TextStyle(
                                //     fontSize: SizeConfig.horizontal * 3,
                                //     color: Color(0xAAFFFFFF),
                                //     fontWeight: FontWeight.w500,
                                //     letterSpacing: 1,
                                //   ),
                                // ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        await profileDataManager.sendPoke(
                                            userEmail, user);
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Poke inviato'),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                )
                                // SizedBox(height: 10,),
                                // Text(
                                //   'Lat: $userLatitude',
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.w500,
                                //     letterSpacing: 1,
                                //   ),
                                // ),
                                // Text(
                                //   'Lon: $userLongitude',
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.w500,
                                //     letterSpacing: 1,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
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
