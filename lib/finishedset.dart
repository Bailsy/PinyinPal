import 'dart:io';
import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pinyinpal/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pinyinpal/piechart.dart';

class FinishedSet extends StatefulWidget {
  final int Tcorrect;
  final int Tincorrect;



  FinishedSet({required this.Tcorrect, required this.Tincorrect, Key? key})
      : super(key: key);

  @override
  _FinishedSet createState() => _FinishedSet();
}

class _FinishedSet extends State<FinishedSet> {
  int score = 0;
  int targetscore = 0; // Set your target number here
  late Timer _timer;

  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    countScore();
    controller.play();
  }
  void countScore(){
      targetscore = widget.Tcorrect*100;
      const time = Duration(milliseconds: 5);
      //here we use a time to count to the score
  
     _timer = Timer.periodic(time, (timer) {
      if (score < targetscore) {
        setState(() {
          score++;
        });
      } else {
        _timer.cancel();
      }
    });

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
            Align(
              alignment: Alignment.center,
              child: Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 300.0,
                    maxWidth: 300.0,
                    minHeight: 30.0,
                    maxHeight: 300,
                  ),
                  child: MyPieChart(
                    value1: widget.Tcorrect,
                    value2: widget.Tincorrect,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 73, 73, 73),
                  ),
                ),
                child: Text(
                  widget.Tcorrect.toString() +
                      " / " +
                      (widget.Tcorrect + widget.Tincorrect).toString(),
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
            
            Container(
            padding: EdgeInsets.only(bottom: 40, left: 60, right: 60),
            child: Align(
              alignment: Alignment.bottomCenter,
                child:Container(
                  width: 350.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                          boxShadow: [                
                         BoxShadow(
                            color: Colors.green.withAlpha(125),
                            blurRadius: 30,
                            spreadRadius: 5,
                            offset: Offset(0, 0),
                                  )                       
                             ],
                    color: Color.fromARGB(255, 72, 72, 72),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text("SCORE"+"\n$score",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'LibreFranklin',
                    color: Color.fromARGB(255, 130, 130, 130),
                        shadows: <Shadow>[
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 3.0,
        color: Color.fromARGB(255, 39, 39, 39),
      ),]
                  ),
                   ),
                )
            )
            )
          ],
        ),      
      ),
    );
  }
}
