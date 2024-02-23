// Dart Imports

// Local Imports
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/pages/profile/profile.dart';
import 'package:pinyinpal/widget/page_navbar.dart';
import 'package:provider/provider.dart';

// PinyinPal Imports
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:pinyinpal/pages/games/flashcard/finishedset.dart';
import 'package:pinyinpal/widget/popups.dart';
import 'package:pinyinpal/models/flashcardtimedmodel.dart';

class FlashCardTimed extends StatefulWidget {
  const FlashCardTimed({super.key});

  @override
  _FlashCardTimedState createState() => _FlashCardTimedState();
}

class _FlashCardTimedState extends State<FlashCardTimed> {
  final TextEditingController pinyinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final flashCardModel = context.read<FlashCardTimedModel>();
    flashCardModel.initializeDataFromDatabase();
  }

  @override
  void dispose() {
    pinyinController.dispose();
    super.dispose();
  }

  Future<void> _handleTextSubmitted(String userAnswer) async {
    final flashCardModel =
        Provider.of<FlashCardTimedModel>(context, listen: false);

    if (userAnswer != flashCardModel.currentHanzi) {
      //Incorrect Answer!
      flashCardModel.increaseIncorrect();
      AnswerDialog.failurePopup(context, "Try again!");
    } else {
      //Correct Answer!
      await flashCardModel.updateScore();
      flashCardModel.increaseCorrect();
      AnswerDialog.successPopup(
          context, '${flashCardModel.currentHanzi} is correct!');
    }

    if (flashCardModel.count == flashCardModel.maxCount) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishedSet(
            Tcorrect: flashCardModel.correct,
            Tincorrect: flashCardModel.incorrect,
          ),
        ),
      );
    }
    flashCardModel.increaseCount();
    flashCardModel.nextQuestion();
    pinyinController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final flashCardModel = context.watch<FlashCardTimedModel>();

    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: DeviceInfo.height / 7,
                left: 60,
                right: 60,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Text(
                      flashCardModel.count.toString(),
                      style: const TextStyle(
                        color: pWhiteColour,
                        fontSize: StylingConstants.pFontSizeLarge,
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
                          flashCardModel
                              .currTranslation, // Use currentHanzi here
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: StylingConstants.pFontSizeMedium,
                            fontFamily: StylingConstants.pStandartFont,
                            color: pWhiteColour,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: DeviceInfo.height / 2.5, left: 80, right: 80),
              child: Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: pinyinController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: pWhiteColour,
                    fontSize: StylingConstants.pFontSizeSmall,
                    fontFamily: StylingConstants.pStandartFont,
                    decoration: TextDecoration.none,
                    decorationThickness: 0,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter Pinyin',
                    hintStyle: TextStyle(color: pLightGreyColour),
                    labelStyle: TextStyle(
                        color: pWhiteColour, //underline color
                        fontSize: StylingConstants.pFontSizeSmall),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: pWhiteColour),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: pWhiteColour),
                    ),
                  ),
                  onSubmitted: _handleTextSubmitted,
                ),
              ),
            ),
          ],
        ));
  }
}
