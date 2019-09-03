import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({this.onTapAction, this.buttonText, this.buttonColor});

  final Function onTapAction;
  final String buttonText;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 3.0,
        child: MaterialButton(
          onPressed: onTapAction,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
