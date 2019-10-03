import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();

  Future<String> getToken() async {
    return await _fcm.getToken();
  }

  void setup(context) {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("${message['notification']['title']}"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${message['notification']['body']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Scopri a chi interessi'),
                  ),
                ],
              ),
            );
          },
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
  }
}
