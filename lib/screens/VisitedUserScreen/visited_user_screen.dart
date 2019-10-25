import 'package:flutter/material.dart';
import 'package:instant_dating/screens/VisitedUserScreen/components/panel.dart';
import 'package:instant_dating/services/schedule.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:provider/provider.dart';

import 'components/panel_title.dart';
import 'components/user_image.dart';

class VisitedUser extends StatelessWidget {
  VisitedUser({this.userImage, this.userEmail, this.userUid});

  final String userImage;
  final String userEmail;
  final String userUid;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      builder: (context) => Schedule(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              UserImage(
                heroTag: userEmail,
                image: userImage,
                userId: userUid,
              ),
              Panel(
                screenSize: MediaQuery.of(context).size.height,
                panel: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.vertical * 3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFBDBDBD),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 4,
                        width: SizeConfig.horizontal * 20,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Christian Arduino, 19',
                                style: TextStyle(
                                  fontSize: SizeConfig.horizontal * 6,
                                ),
                              ),
                              PanelTitle(title: 'Interessi'),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: SizeConfig.horizontal * 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.computer,
                                        size: SizeConfig.horizontal * 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.directions_car,
                                        size: SizeConfig.horizontal * 7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PanelTitle(title: 'Bio'),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Duis feugiat commodo condimentum. Praesent arcu odio, molestie sit amet euismod nec, eleifend vel ligula. Vivamus accumsan ligula in erat porta, a suscipit orci cursus. Etiam eget egestas felis. Quisque porta tortor et odio condimentum, in vestibulum lectus sagittis. Nulla quis lorem sed ex tincidunt mollis non a lectus. Vivamus convallis, orci id semper dignissim, purus quam tempor velit, a volutpat tortor ex nec lorem. Phasellus at luctus est. Duis at tellus finibus, vulputate odio a, convallis velit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
                                  style: TextStyle(
                                    fontSize: SizeConfig.horizontal * 3.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Hero(
                  tag: 'arrow_back',
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: SizeConfig.horizontal * 10,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
