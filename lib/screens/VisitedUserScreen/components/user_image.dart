import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/components/gradient_opacity.dart';
import 'package:instant_dating/screens/fullimage_screen.dart';
import 'package:instant_dating/services/schedule.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:provider/provider.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    Key key,
    @required this.heroTag,
    @required this.image,
    @required this.userId,
  }) : super(key: key);

  final String heroTag; //equal to email
  final String image;
  final String userId;

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  final double collapsedHeightFactor = 0.85;
  final double expandedHeightFactor = 0.20;
  double minusVal = 0.0;
  bool isCollapsed = true;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _heightFactorAnimation = Tween<double>(
      begin: collapsedHeightFactor,
      end: expandedHeightFactor,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<Schedule>(
      builder: (context, schedule, _) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor:
                _heightFactorAnimation.value - (schedule.getMinusVal / 4),
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: widget.heroTag,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullImageScreen(
                        image: widget.image,
                        heroTag: widget.heroTag,
                      ),
                    ),
                  ),
                  child: Hero(
                    tag: widget.userId,
                    child: GradientOpacity(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
