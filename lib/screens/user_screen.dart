import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  UserScreen({this.user});

  static final id = 'user_screen';
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
      body: Stack(
        children: <Widget>[
          Container(
            height: height / 2.5,
            color: Colors.purple,
          ),
          SizedBox(
            height: height / 2.3,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: height / 2.3),
                child: CircleAvatar(
                  child: Image.network(loggedUser.photoUrl),
                ),
              ),
              Text(
                loggedUser.displayName,
                style: TextStyle(
                  fontSize: width / 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 2),
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
        ],
      ),
    );
  }
}
