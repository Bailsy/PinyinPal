import 'dart:io';
import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pinyinpal/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pinyinpal/piechart.dart';

class FinishedSet extends StatefulWidget {
  // It is essential to give the class a key and make it constant
   final int Tcorrect;
   final int Tincorrect;

   FinishedSet({required this.Tcorrect, required this.Tincorrect, Key? key}) : super(key: key);

  @override
  _FinishedSet createState() => _FinishedSet();
}

class _FinishedSet extends State<FinishedSet> {
  bool isPlaying = false;
  final controller = ConfettiController();



  @override
  void initState(){
    super.initState();
    controller.play();
  }

  Widget confetti(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controller,
        particleDrag: 0.04,
        blastDirection: 1.570796,
        emissionFrequency: 0.0,
        numberOfParticles: 20,
        minBlastForce: 5,
        maxBlastForce: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 26),
              ),
            ),
            confetti(context),
            MyPieChart(value1: widget.Tcorrect, value2: widget.Tincorrect,),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 73, 73, 73),
                  ),
                ),
                child: Text(
                  widget.Tcorrect.toString() + " / " + (widget.Tcorrect+widget.Tincorrect).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'LibreFranklin',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                onPressed: () {
                  print('pressed!');
                },
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
