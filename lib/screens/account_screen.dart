import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:instant_dating/services/user_account.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({this.user, this.key});

  static final id = 'user_screen';
  final Key key;
  final user;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var loggedUser = widget.user;
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: SizeConfig.vertical * 20,
                color: Colors.purple,
              ),
              GestureDetector(
                onTap: () async => await UserAccount().googleLogout(context),
                child: Icon(Icons.close),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: loggedUser.photoUrl,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            margin:
                                EdgeInsets.only(top: SizeConfig.vertical * 13),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(loggedUser.photoUrl),
                              radius: SizeConfig.horizontal * 13,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.vertical * 1,
                      ),
                      Text(
                        loggedUser.displayName,
                        style: TextStyle(
                          fontSize: SizeConfig.horizontal * 5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
