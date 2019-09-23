import 'package:flutter/material.dart';
import 'package:instant_dating/services/schedule.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Panel extends StatefulWidget {
  Panel({this.panel, this.screenSize});

  final panel;
  final screenSize;

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    animation = Tween<double>(
      begin: 0,
      end: widget.screenSize / 3.6,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    )..addListener(() => setState(() {}));
    _controller.forward();
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
    final schedule = Provider.of<Schedule>(context);
    return SlidingUpPanel(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
      onPanelSlide: (val) {
        if (cycle == 0) {
          cycle++;
        } else {
          schedule.minusVal = val;
        }
      },
      minHeight: animation.value,
      maxHeight: SizeConfig.vertical * 45,
      panel: widget.panel,
    );
  }
}
