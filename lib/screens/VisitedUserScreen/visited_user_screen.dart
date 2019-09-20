import 'package:flutter/material.dart';
import 'package:instant_dating/components/gradient_opacity.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class VisitedUser extends StatefulWidget {
  VisitedUser({this.userImage, this.userEmail});

  final String userImage;
  final String userEmail;

  @override
  _VisitedUserState createState() => _VisitedUserState();
}

class _VisitedUserState extends State<VisitedUser>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  final double collapsedHeightFactor = 0.83;
  final double expandedHeightFactor = 0.55;
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
    var cycle = 0;
    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactorAnimation.value - (minusVal / 4),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: widget.userEmail,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.userImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      GradientOpacity(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: SizeConfig.horizontal * 10,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SlidingUpPanel(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                  onPanelSlide: (val) {
                    if (cycle == 0) {
                      cycle++;
                    } else {
                      setState(() {
                        minusVal = val;
                      });
                    }
                  },
                  minHeight: SizeConfig.vertical * 25,
                  maxHeight: SizeConfig.vertical * 45,
                  panel: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.userEmail}, 19',
                          style: TextStyle(
                            fontSize: SizeConfig.horizontal * 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//FractionallySizedBox(
//alignment: Alignment.bottomCenter,
//heightFactor: 1.05 - _heightFactorAnimation.value,
//child: Container(
//decoration: BoxDecoration(
//color: Colors.white,
//borderRadius: BorderRadius.only(
//topLeft: Radius.circular(40.0),
//topRight: Radius.circular(40.0),
//),
//),
//child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//SizedBox(
//height: SizeConfig.vertical * 3,
//),
//Padding(
//padding: EdgeInsets.only(left: 16.0),
//child: RichText(
//text: TextSpan(
//text: 'Christian Arduino',
//style: TextStyle(
//fontSize: SizeConfig.horizontal * 5,
//fontWeight: FontWeight.bold,
//color: Colors.black,
//),
//children: [
//TextSpan(
//text: ', 18',
//style: TextStyle(
//fontSize: SizeConfig.horizontal * 5,
//fontWeight: FontWeight.w400,
//color: Colors.black,
//),
//)
//]),
//),
//),
//],
//),
//),
//),
