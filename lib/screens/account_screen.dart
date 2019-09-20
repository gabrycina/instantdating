import 'package:flutter/material.dart';
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: height / 3.7,
                color: Colors.purple,
              ),
              GestureDetector(
                onTap: () async => await UserAccount().googleLogout(context),
                child: Icon(Icons.close),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         Container(
              //           margin: EdgeInsets.only(top: height / 7),
              //           width: width / 3,
              //           height: height / 5,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             image: DecorationImage(
              //                 image: NetworkImage(loggedUser.photoUrl),
              //                 fit: BoxFit.cover),
              //           ),
              //         ),
              //         Text(
              //           loggedUser.displayName,
              //           style: TextStyle(
              //             fontSize: width / 20,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: height / 7,
                        ),
                        height: height / 5,
                        width: width / 3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(60, 0, 0, 0),
                              blurRadius: 5.0,
                              offset: Offset(5.0, 5.0),
                            )
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(loggedUser.photoUrl),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 60,
                      ),
                      Text(
                        loggedUser.displayName,
                        style: TextStyle(
                          fontSize: width / 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height / 2.1,
                  left: width / 20,
                  right: width / 20,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Bio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam consectetur justo et faucibus convallis. Suspendisse interdum ornare dui, at congue sem iaculis nec. Nullam faucibus ante nisl, nec blandit turpis placerat semper. Ut eleifend viverra condimentum. Nullam at libero tortor. Proin tincidunt tempor quam vel rutrum. Donec at lorem eros. ',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
