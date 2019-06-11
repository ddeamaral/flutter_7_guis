import 'dart:async' as flutter;

import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  Timer({this.title});

  final String title;

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int _secondsValue = 0;
  int _secondsRemaining = 0;
  double progressValue = 0.5;
  Stopwatch watch = new Stopwatch();
  flutter.Timer timer;
  final double MAX_SLIDER_VALUE = 20;

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
              style: TextStyle(fontSize: 48),
            ),
            Text(
              "${_secondsRemaining.toString()} seconds",
              style: TextStyle(fontSize: 24),
            ),
            Slider(
              value: _secondsValue.toDouble(),
              min: 0,
              max: MAX_SLIDER_VALUE,
              onChanged: (double sliderValue) {
                watch.reset();
                if (timer != null) {
                  timer.cancel();
                }

                setState(() {
                  timer = null;
                  _secondsValue = sliderValue.floor();
                  _secondsRemaining = sliderValue.floor();
                  progressValue = 0;
                });
              },
              onChangeEnd: (double sliderValue) {
                if (timer != null) {
                  // Not sure why onChangeEnd is being called multiple times...
                  // Resetting the timer every time causes issues too
                  return;
                }

                watch.start();
                timer = flutter.Timer.periodic(Duration(seconds: 1), (t) {
                  print(
                      'tick ${t.tick}, ${watch.elapsed.inSeconds.toDouble()} / $_secondsValue = $progressValue, $_secondsValue');

                  setState(() {
                    progressValue =
                        watch.elapsed.inSeconds.toDouble() / _secondsValue;
                    _secondsRemaining = _secondsRemaining - 1;
                  });

                  if (watch.elapsed.inSeconds >= _secondsValue) {
                    t.cancel();
                    watch.reset();
                  }
                });
              },
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.red,
              value: progressValue,
            )
          ],
        ),
      ),
    );
  }
}
