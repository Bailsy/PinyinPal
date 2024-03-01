import 'dart:async';
import 'package:flutter/material.dart';

class LinearTimer extends StatefulWidget {
  final int durationMilliseconds;
  final VoidCallback onTimerFinish;
  final bool cancelled;

  const LinearTimer({
    Key? key,
    required this.cancelled,
    required this.durationMilliseconds,
    required this.onTimerFinish,
  }) : super(key: key);

  @override
  _LinearTimerState createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  late int _millisecondsRemaining;
  late double _barWidth;
  int durationMilliseconds = 17;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _millisecondsRemaining = widget.durationMilliseconds;
    _barWidth = 1.0;
    startTimer();
  }

  void startTimer() {
    _timer =
        Timer.periodic(Duration(milliseconds: durationMilliseconds), (timer) {
      setState(() {
        if (_millisecondsRemaining > 0) {
          _millisecondsRemaining -= durationMilliseconds;
          _barWidth = _millisecondsRemaining <= 0
              ? 0
              : _millisecondsRemaining / widget.durationMilliseconds;
        } else {
          widget.onTimerFinish();
          timer.cancel();
        }
        if (widget.cancelled) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _barWidth,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    _millisecondsRemaining <= 0 ? "" : (""),
                    style: TextStyle(
                      color: _millisecondsRemaining <= 0
                          ? Colors.white
                          : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
