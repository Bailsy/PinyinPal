// Dart Imports
import 'dart:ui';

// Local Imports
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:provider/provider.dart';

// PinyinPal Imports
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:pinyinpal/pages/finishedset.dart';
import 'package:pinyinpal/widget/popups.dart';
import 'package:pinyinpal/widget/appbarwidget.dart';
import 'package:pinyinpal/pages/modes/flashcardrace/flashcardtimedmodel.dart';

class FlashCardTimed extends StatelessWidget {
  const FlashCardTimed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => FlashCardTimedModel(),
        child: FlashCardTimedBody(),
      ),
    );
  }
}

class FlashCardTimedBody extends StatefulWidget {
  @override
  _FlashCardTimedBodyState createState() => _FlashCardTimedBodyState();
}

class _FlashCardTimedBodyState extends State<FlashCardTimedBody> {
  final TextEditingController pinyinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FlashCardTimed()));
    final flashCardModel = context.read<FlashCardTimedModel>();
    flashCardModel.initializeDataFromDatabase();
  }

  @override
  void dispose() {
    pinyinController.dispose();
    super.dispose();
  }

  void _handleTextSubmitted(String userAnswer) {
    final flashCardModel =
        Provider.of<FlashCardTimedModel>(context, listen: false);

    if (userAnswer != flashCardModel.currentHanzi) {
      //Incorrect Answer!
      AnswerDialog.failurePopup(context, "Try again!");
    } else {
      //Correct Answer!
      flashCardModel.increaseCorrect();
      AnswerDialog.successPopup(
          context, '${flashCardModel.currentHanzi} is correct!');

      //Check if that was the last question
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

      flashCardModel.nextQuestion(); // Call the method to update hanzi
    }

    //AnswerDialog.successPopup(context, flashCardModel.currhanzi);
    //AnswerDialog.failurePopup(context, flashCardModel.currhanzi);
    pinyinController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final flashCardModel = context.watch<FlashCardTimedModel>();

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: DeviceInfo.height / 5,
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
                      flashCardModel.currTranslation, // Use currentHanzi here
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
          padding:
              EdgeInsets.only(top: DeviceInfo.height / 2, left: 80, right: 80),
          child: Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: pinyinController,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: pWhiteColour,
                fontSize: StylingConstants.pFontSizeSmall,
                fontFamily: StylingConstants.pStandartFont,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter Pinyin',
                hintStyle: TextStyle(color: pLightGreyColour),
                labelStyle: TextStyle(color: pWhiteColour),
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
    );
  }
}
