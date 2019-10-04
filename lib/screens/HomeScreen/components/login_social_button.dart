import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';

class LoginSocialButton extends StatelessWidget {
  const LoginSocialButton({
    Key key,
    this.color,
    this.label,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final String label;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: SizeConfig.horizontal * 80,
          height: SizeConfig.horizontal * 12,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontal * 5,
              vertical: SizeConfig.horizontal * 3),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: SizeConfig.horizontal * 4.5),
          ),
        ),
      ),
    );
  }
}
