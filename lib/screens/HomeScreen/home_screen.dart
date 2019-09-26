import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:instant_dating/components/devices_location_list.dart';
import 'package:instant_dating/services/size_config.dart';

import 'components/top_rounded_container.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user, this.key});

  static final id = 'home_screen';
  final Key key;
  final user;
//  final String type;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var loggedUser;
  String accountName;
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
    loggedUser = widget.user;
    accountName = loggedUser.email;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xFFececec),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Stack(
              children: <Widget>[
                TopRoundedContainer(
                  pubName: 'Random Pub',
                  subTitle: '2.500 visite mensili',
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.vertical * 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 10,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          child: SmoothStarRating(
                            spacing: 6,
                            allowHalfRating: false,
                            onRatingChanged: (v) {
                              rating = v;
                              setState(() {});
                            },
                            starCount: 5,
                            rating: rating,
                            size: SizeConfig.horizontal * 9,
                            color: Color(0xFFFF655B),
                            borderColor: Color(0xFFFF655B),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            DevicesLocation(
              accountName: accountName,
              user: loggedUser,
            ),
          ],
        ),
      ),
    );
  }
}
