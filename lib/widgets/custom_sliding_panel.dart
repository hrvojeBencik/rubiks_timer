import 'package:flutter/material.dart';
import 'package:rubiks_timer/models/scramble_algorithm.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomSlidingPanel extends StatefulWidget {
  final Widget body;
  CustomSlidingPanel({this.body});
  @override
  _CustomSlidingPanelState createState() => _CustomSlidingPanelState();
}

class _CustomSlidingPanelState extends State<CustomSlidingPanel> {
  double _opacity = 0;
  double _upArrowHeight = 20;
  double _upArrowOpacity = 1;
  String _scrambleAlgorithm = '';
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      panel: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 150),
            opacity: _opacity,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  Text(
                    _scrambleAlgorithm != ''
                        ? _scrambleAlgorithm
                        : "Generating...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Tap anywhere to generate new algorithm.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  )
                ],
              ),
            ),
          )),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      onPanelSlide: (value) {
        setState(() {
          if (value == 1)
            _opacity = value;
          else
            _opacity = 0;
        });
      },
      onPanelOpened: () {
        setState(() {
          _upArrowHeight = 0;
          _upArrowOpacity = 0;
          _scrambleAlgorithm = ScrambleAlgorithm.generate();
        });
      },
      onPanelClosed: () {
        setState(() {
          _upArrowOpacity = 1;
          _upArrowHeight = 20;
        });
      },
      collapsed: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            height: _upArrowHeight,
            curve: Curves.bounceOut,
            child: AnimatedOpacity(
              duration: Duration(microseconds: 400),
              opacity: _upArrowOpacity,
              child: Icon(
                Icons.arrow_upward,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
          Text(
            "Scrambling algorithm",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
      minHeight: 70,
      maxHeight: 200,
      parallaxEnabled: false,
      padding: EdgeInsets.only(
        top: 4,
        bottom: 10,
      ),
      color: Color(0xFF222831).withOpacity(0.9),
      body: widget.body,
    );
  }
}
