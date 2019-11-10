import 'package:flutter/material.dart';
import 'package:instant_dating/screens/VisitedUserScreen/components/panel.dart';
import 'package:instant_dating/services/schedule.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:provider/provider.dart';

import 'components/panel_title.dart';
import 'components/user_image.dart';

class VisitedUser extends StatelessWidget {
  VisitedUser({this.receiverUserImage, this.receiverUserEmail, this.receiverUserUid, this.receiverUserNickname, this.receiverUserAge, this.receiverUserBio});

  final String receiverUserImage;
  final String receiverUserEmail;
  final String receiverUserUid;
  final String receiverUserNickname;
  final int receiverUserAge;
  final String receiverUserBio;

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
                heroTag: receiverUserEmail,
                image: receiverUserImage,
                userId: receiverUserUid,
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
                                '$receiverUserNickname, $receiverUserAge',
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
                                  '$receiverUserBio',
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
