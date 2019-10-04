import 'package:instant_dating/services/size_config.dart';

import 'gesture_card_deck.dart';
import 'package:flutter/material.dart';

class SwipeCard extends StatelessWidget {
  SwipeCard({this.data, this.userImage, this.userEmail});

  final List data;
  final userImage;
  final userEmail;

  @override
  Widget build(BuildContext context) {
    return new GestureCardDeck(
      isButtonFixed: true,
      showAsDeck: true,
      fixedButtonPosition:
          Offset(SizeConfig.horizontal * 25, SizeConfig.vertical * 76),
      data: data,
      animationTime: Duration(milliseconds: 500),
      velocityToSwipe: 1200,
      leftSwipeButton: Container(
        child: CircleAvatar(
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).accentColor,
          radius: SizeConfig.horizontal * 7.5,
        ),
      ),
      rightSwipeButton: Container(
        child: CircleAvatar(
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          radius: SizeConfig.horizontal * 7.5,
        ),
      ),
      onSwipeLeft: (index) {
        print("on swipe left");
        print(index);
      },
      onSwipeRight: (index) {
        print("on swipe right");
        print(index);
      },
      onCardTap: (index) {},
      leftPosition: SizeConfig.horizontal * 9.5,
      topPosition: SizeConfig.vertical * 2,
      leftSwipeBanner: Padding(
        padding: EdgeInsets.all(32.0),
        child: Transform.rotate(
          angle: 0.5,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "NOPE",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      rightSwipeBanner: Padding(
        padding: EdgeInsets.all(32.0),
        child: Transform.rotate(
          angle: -0.5,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "YEAH",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
