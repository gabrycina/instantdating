import 'package:flutter/material.dart';

class GradientOpacity extends StatelessWidget {
  const GradientOpacity({Key key, this.child}) : super(key: key);

  final child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.4,
            1,
          ],
          colors: [
            Colors.transparent,
            Color(0xDD050505),
          ],
        ),
      ),
      child: child == null ? SizedBox.expand() : child,
    );
  }
}
