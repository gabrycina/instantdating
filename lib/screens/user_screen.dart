import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  UserScreen({this.user, this.key});

  static final id = 'user_screen';
  final Key key;
  final user;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    var loggedUser = widget.user;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Instant Dating(Prototype)'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: height / 3.7,
                color: Colors.purple,
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
                          borderRadius: BorderRadius.circular(100.0),
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
