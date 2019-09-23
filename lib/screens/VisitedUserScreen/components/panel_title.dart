import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';

class PanelTitle extends StatelessWidget {
  PanelTitle({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.horizontal * 4,
          color: Color(0xFFFE3C72),
        ),
      ),
    );
  }
}
