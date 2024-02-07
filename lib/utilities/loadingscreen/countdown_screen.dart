import 'package:flutter/material.dart';

class CountdownScreen extends StatefulWidget {
  final VoidCallback onCountdownFinished;

  const CountdownScreen({super.key, required this.onCountdownFinished});

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int countdownValue = 3;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        countdownValue--;
        if (countdownValue > 0) {
          startCountdown();
        } else {
          widget.onCountdownFinished();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$countdownValue...',
          style: const TextStyle(fontSize: 36.0),
        ),
      ),
    );
  }
}
