import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/components/gradient_opacity.dart';
import 'package:instant_dating/screens/VisitedUserScreen/components/panel_title.dart';
import 'package:instant_dating/services/user_repository.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({this.key});

  static final id = 'user_screen';
  final Key key;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //TODO: Implement imageUrls
            SizedBox.expand(
              child: CachedNetworkImage(
                //TODO: Remove static placeholders
                imageUrl: 'https://images.unsplash.com/photo-1552162864-987ac51d1177?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80',
                fit: BoxFit.cover,
              ),
            ),
            GradientOpacity(),
            SlidingUpPanel(
              minHeight: SizeConfig.vertical * 30,
              maxHeight: SizeConfig.vertical * 45,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              panel: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: SizeConfig.vertical * 3),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Christian Arduino, 19',
                                  style: TextStyle(
                                    fontSize: SizeConfig.horizontal * 6,
                                  ),
                                ),
                                Icon(
                                  Icons.edit,
                                  size: SizeConfig.horizontal * 7,
                                )
                              ],
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
            GestureDetector(
              onTap: () => Provider.of<UserRepository>(context).signOut(),
              child: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
