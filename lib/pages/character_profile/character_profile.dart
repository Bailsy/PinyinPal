// character_profile_page.dart
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/character_profile_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/services/apI_service.dart';
import 'package:provider/provider.dart';

class CharacterProfilePage extends StatelessWidget {
  final HskEntry selectedCharacter;
  const CharacterProfilePage({required this.selectedCharacter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
      ),
      body: CharacterProfileBody(selectedCharacter: selectedCharacter),
    );
  }
}

class CharacterProfileBody extends StatefulWidget {
  final HskEntry selectedCharacter;
  const CharacterProfileBody({required this.selectedCharacter});

  @override
  _CharacterProfileBodyState createState() => _CharacterProfileBodyState();
}

class _CharacterProfileBodyState extends State<CharacterProfileBody> {
  late List<ExampleSentence> exampleSentences = [];

  @override
  void initState() {
    super.initState();
    final characterProfileModel = context.read<CharacterProfileModel>();
    characterProfileModel
        .fetchExampleSentences(widget.selectedCharacter.simplified);
  }

  @override
  Widget build(BuildContext context) {
    final characterProfileModel = context.watch<CharacterProfileModel>();

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.selectedCharacter.pinyin_tones,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: StylingConstants.pFontSizeMedium,
                    fontFamily: StylingConstants.pStandartFont,
                    color: Colors.white,
                  ),
                ),
                // Audio playback button for the selected character
                ElevatedButton(
                  //_playaudio is in model
                  onPressed: () =>
                      characterProfileModel.playAudio(widget.selectedCharacter),
                  child: const Text('Play Audio'),
                ),
              ],
            ),
            // Display other relevant information

            // Example sentences section
            ExpansionTile(
              title: Text('Example Sentences'),
              textColor: Colors.white,
              children: [
                Column(
                  children: characterProfileModel.exampleSentences
                      .map((sentence) => ListTile(
                            title: Text(sentence.hanzi),
                            textColor: Colors.white,
                            subtitle: Text(sentence.translation),
                          ))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
