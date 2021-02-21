import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rubiks_timer/widgets/custom_sliding_panel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _resetButtonController;
  Animation _resetButtonAnimation;
  Color _resetButtonColor;

  bool _isStarted = false;
  double _time = 0;

  @override
  void initState() {
    super.initState();
    _resetButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _resetButtonAnimation = ColorTween(
            begin: Color(0xFF51c2d5), end: Color(0xFF51c2d5).withOpacity(0.4))
        .animate(_resetButtonController);

    _resetButtonAnimation.addListener(() {
      setState(() {
        _resetButtonColor = _resetButtonAnimation.value;
      });
    });

    _resetButtonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSlidingPanel(
        body: GestureDetector(
          onTap: _switchTimer,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rubik's Timer",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  _formattedTime(_time),
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: _isStarted ? null : _resetTimer,
                  child: Text(
                    'Reset Timer',
                    style: TextStyle(
                      fontSize: 24,
                      color: _resetButtonColor,
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.1)),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _switchTimer() {
    setState(() {
      _isStarted = !_isStarted;
      if (_isStarted) {
        _resetButtonController.forward();
        _startTimer();
      } else {
        _resetButtonController.reverse();
      }
    });
  }

  void _startTimer() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (!_isStarted) {
        timer.cancel();
      }
      setState(() {
        _time += 10;
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _time = 0.0;
      _resetButtonController.forward();
    });
  }

  String _formattedTime(double time) {
    String seconds = (time ~/ 1000).toString();
    String miliseconds = (time % 1000 ~/ 10).toString();
    String minutes = "";
    if (time / 1000 >= 60) {
      minutes = (time ~/ 1000 ~/ 60).toString();
      seconds = (time ~/ 1000 - ((time ~/ 1000 ~/ 60) * 60)).toString();
    }
    if (minutes != "") {
      return minutes + ":" + seconds + ":" + miliseconds;
    }
    return seconds + ":" + miliseconds;
  }
}
