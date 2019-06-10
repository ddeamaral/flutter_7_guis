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
  Stopwatch watch = new Stopwatch();
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
                });
              },
              onChangeEnd: (double sliderValue) {
                if (timer != null) {
                  // Not sure why onChangeEnd is being called multiple times...
                  // Resetting the timer every time causes issues too
                  return;
                }

                timer = flutter.Timer.periodic(Duration(seconds: 1), (_timer) {
                  if (watch.elapsed.inSeconds > 0 && _secondsValue > 0) {
                    print("calling state overwrite");
                    print(_secondsValue);
                    setState(() {
                      // THIS SET STATE DOESN'T WORK
                      progressValue =
                          watch.elapsed.inSeconds / _secondsValue == 0
                              ? 1
                              : _secondsValue;
                      _secondsValue = _secondsValue - watch.elapsed.inSeconds;
                    });
                  }
                });
                watch.start();
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
