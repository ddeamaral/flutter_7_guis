import 'dart:async' as flutter;

import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  Timer({this.title});

  final String title;

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int _secondsValue = 0;
  double progressValue = 0;
  AnimationController animationController;
  Animation<Color> animation;
  flutter.Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Duration:",
              style: TextStyle(fontSize: 24),
            ),
            Text("${_secondsValue.toString()} seconds"),
            Slider(
              value: _secondsValue.toDouble(),
              min: 0,
              max: 20,
              onChanged: (double sliderValue) {
                setState(() {
                  _secondsValue = sliderValue.floor();
                  timer = flutter.Timer.periodic(
                      Duration(seconds: _secondsValue), (_timer) {
                    progressValue = _timer.tick / _secondsValue;
                    print("${progressValue} = $_timer.tick");
                  });
                });
              },
              onChangeEnd: (double sliderValue) {
                int milliseconds = (_secondsValue * 1000).toInt();

                Duration d = new Duration(milliseconds: milliseconds);
              },
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.red,
              value: progressValue,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
