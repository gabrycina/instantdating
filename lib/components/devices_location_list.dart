import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instant_dating/utilities/profile_data_manager.dart';


final _firestore = Firestore.instance;

class DevicesLocation extends StatelessWidget {
  DevicesLocation({this.accountName, this.user});

  final String accountName;
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                padding: EdgeInsets.symmetric(vertical: height * 0.009, horizontal: width * 0.009),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      //TODO: show user profile
                      print('pressed1');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                width / 40, 10, width / 40, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                userImage == null
                                    ? Icon(Icons.notifications_active)
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(userImage),
                                      ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30.0),
                                  onTap: () async {
                                    await profileDataManager.sendPoke(userEmail, user);
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('Poke Sent'),)
                                    );
                                  },
                                  child: Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              //TODO: change with username by google
                              Text(
                                userEmail,
                                style: TextStyle(
                                    fontSize: width / 25,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                //TODO: change with position
                                'Meno di 1km di distanza',
                                style: TextStyle(
                                  fontSize: width / 33,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          //show other image than the first one
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: userImage == null
                                      ? Icon(Icons.notifications_active)
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userImage),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: userImage == null
                                      ? Icon(Icons.notifications_active)
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userImage),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: userImage == null
                                      ? Icon(Icons.notifications_active)
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userImage),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: userImage == null
                                      ? Icon(Icons.notifications_active)
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userImage),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: userImage == null
                                      ? Icon(Icons.notifications_active)
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(userImage),
                                        ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }

        return GridView.count(
          crossAxisCount: 2,
          children: usersDocsDecoded,
        );
      },
    );
  }
}
