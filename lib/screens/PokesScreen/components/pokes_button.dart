import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:instant_dating/services/size_config.dart';

class PokeButton extends StatelessWidget {
  PokeButton({this.backgroundColor, this.icon, this.borderRadius, this.onTap});

  final backgroundColor;
  final icon;
  final borderRadius;
  final onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          height: SizeConfig.vertical * 5,
          child: Center(
            child: IconShadowWidget(
              Icon(
                icon,
                color: Colors.white,
                size: SizeConfig.horizontal * 8,
              ),
              shadowColor: Color(0x77000000),
            ),
          ),
        ),
      ),
    );
  }
}
