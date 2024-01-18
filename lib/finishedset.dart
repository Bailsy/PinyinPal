import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pinyinpal/experiencepoints.dart';
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

            Align(
              alignment: Alignment.center,
              child: Container(
      
  
                child: ExperiencePoints(totaltime: score),
                
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
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
                  score.toString(),
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
