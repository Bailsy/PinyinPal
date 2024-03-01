import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/databasecontrol.dart';
import 'package:pinyinpal/models/lvl.dart';
import 'package:pinyinpal/widget/page_navbar.dart';
import 'package:pinyinpal/services/json_uploader.dart';
import 'package:pinyinpal/widget/experiencepoints.dart';
import 'package:pinyinpal/widget/piechart.dart';

class FinishedSet extends StatefulWidget {
  final int Tcorrect;
  final int Tincorrect;

  const FinishedSet(
      {required this.Tcorrect, required this.Tincorrect, super.key});

  @override
  _FinishedSet createState() => _FinishedSet();
}

class CardTotals {
  static int correct = 0;
  static int incorrect = 0;
}

class _FinishedSet extends State<FinishedSet> {
  int score = 0;
  int targetscore = 0; // Set your target number here
  late Timer _timer;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    countScore();
    UploadJson uj = UploadJson();
    uj.uploadStats(HskPath.hsklvl, widget.Tcorrect, widget.Tincorrect); //! ?
    DataBaseIntegration.updateXP(widget.Tcorrect * 100);
    print("yip everything is uploaded!");
    waiter();
  }

  void waiter() async {
    await Future.delayed(const Duration(milliseconds: 10000));
  }

  void countScore() {
    targetscore = widget.Tcorrect * 100;
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

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewHomePage()));
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            PopScope(canPop: false, child: Container()),
            Container(
              decoration: const BoxDecoration(
                color: pGreyColour,
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
              child: Text(
                score.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'LibreFranklin',
                  color: pWhiteColour,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
