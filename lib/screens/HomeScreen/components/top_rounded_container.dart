import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.pubName,
    @required this.subTitle,
  }) : super(key: key);

  final String pubName;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.vertical * 17.5,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: SizeConfig.vertical * 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [
            0.1,
            0.5,
          ],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xFFFD297B),
            Color(0xFFFF5864),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(
              SizeConfig.horizontal * 30, SizeConfig.horizontal * 10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            pubName,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.horizontal * 11,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: Color(0xFFF7F7F7),
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.horizontal * 3.2,
            ),
          ),
          SizedBox(
            height: SizeConfig.vertical * 4,
          )
        ],
      ),
    );
  }
}
