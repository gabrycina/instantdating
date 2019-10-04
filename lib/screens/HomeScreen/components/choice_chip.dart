import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';

class ChipChoice extends StatelessWidget {
  ChipChoice({this.icon, this.label, this.isSelected, this.onTap});

  final IconData icon;
  final String label;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              )
            : BoxDecoration(),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: SizeConfig.horizontal * 5.5,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.horizontal * 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
