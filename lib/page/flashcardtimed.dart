// Dart Imports
import 'dart:ui';

// Local Imports
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/colour.dart';

// PinyinPal Imports
import 'package:pinyinpal/model/databasecontrol.dart';
import 'package:pinyinpal/page/finishedset.dart';
import 'package:pinyinpal/page/home.dart';
import 'package:pinyinpal/widget/popups.dart';

class FlashCardTimed extends StatefulWidget {
  const FlashCardTimed({Key? key});

  @override
  State<FlashCardTimed> createState() => _FlashCardTimed();
}

class _FlashCardTimed extends State<FlashCardTimed> {
  final TextEditingController pinyinController = TextEditingController();

  @override
  void dispose() {
    pinyinController.dispose();
    super.dispose();
  }

  int count = 0;
  int max = 0;
  double height = 0;
  int correct = 5;
  int incorrect = 4;
  String hanzi = "nothing";
  int maxcount = 1;

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    Future<int> futureMax = DataBaseIntegration.getDBsize();
    futureMax.then((intResult) {
      max = intResult;
    });
    var physicalScreenSize = window.physicalSize;
    height = physicalScreenSize.height / 2;
    print(height);
  }

  void _incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Center(
        child: Stack(
          children: <Widget>[
            AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  icon: const Icon(LineAwesomeIcons.angle_left)),
            ),
            Container(
              child: buildFutureBuilder(),
            ),
            Container(
              padding: EdgeInsets.only(top: height / 3, left: 80, right: 80),
              child: Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: pinyinController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: pWhiteColour,
                      fontSize: 20,
                      fontFamily: 'LibreFranklin'),
                  decoration: const InputDecoration(
                    hintText: 'Enter Pinyin',
                    hintStyle: TextStyle(color: pDarkGreyColour),
                    labelStyle: TextStyle(color: pWhiteColour),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: pWhiteColour),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: pWhiteColour),
                    ),
                  ),
                  onSubmitted: (value) {
                    //when the enter button is pressed on the keyboard this is the text which will be printed
                    if (count == maxcount) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FinishedSet(
                                    Tcorrect: correct,
                                    Tincorrect: incorrect,
                                  )));
                    }
                    if (pinyinController.text == hanzi && count != maxcount) {
                      correct++;
                      AnswerDialog.successPopup(context, hanzi);
                    }
                    if (pinyinController.text != hanzi && count != maxcount) {
                      incorrect++;
                      AnswerDialog.failurePopup(context, hanzi);
                    }
                    _incrementCounter();
                    pinyinController.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }

  Widget buildFutureBuilder() {
    return FutureBuilder(
      future: DataBaseIntegration.connectToDB(count),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> normalList = snapshot.data as List<String>;

          hanzi = normalList[0];

          return Container(
            padding: EdgeInsets.only(top: height / 5, left: 60, right: 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                 Text(
                    (count).toString(),
                    style: const TextStyle(
                      color: pWhiteColour,
                      fontSize: 45,
                    ),
                  ),
                  Container(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 300.0,
                        maxWidth: 300.0,
                        minHeight: 30.0,
                        maxHeight: 100.0,
                      ),
                      child: AutoSizeText(
                        normalList[2],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'LibreFranklin',
                            color: pWhiteColour),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
