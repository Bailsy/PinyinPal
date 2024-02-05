import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/character_profile_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:provider/provider.dart';

class CharacterProfilePage extends StatelessWidget {
  final HskEntry selectedCharacter;
  final Color confidence;
  const CharacterProfilePage(
      {required this.selectedCharacter, required this.confidence});

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
      body: CharacterProfileBody(
        selectedCharacter: selectedCharacter,
        confidence: confidence,
      ),
    );
  }
}

class CharacterProfileBody extends StatefulWidget {
  final HskEntry selectedCharacter;
  final Color confidence;
  const CharacterProfileBody(
      {required this.selectedCharacter, required this.confidence});

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
                Container(
                  width: 20,
                ),
                ElevatedButton(
                  //_playaudio is in model
                  onPressed: () =>
                      characterProfileModel.playAudio(widget.selectedCharacter),
                  child: const Iconify(
                    Ph.speaker_high_fill,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                Container(
                  width: 20,
                ),
                Iconify(
                  Ph.circle_fill,
                  color: widget.confidence,
                  size: 30,
                ),
              ],
            ),
            // Display other relevant information

            // Example sentences section

            //show the translation
            Container(height: 30),

            ExpansionTile(
              title: const Text(
                'Translation',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'LibreFranklin',
                    color: Colors.grey),
              ),
              collapsedIconColor: Colors.grey,
              textColor: Colors.white,
              children: [
                Column(children: <Widget>[
                  Text(
                    widget.selectedCharacter.translation,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: StylingConstants.pStandartFont,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 19,
                  )
                ]),
              ],
            ),

            ExpansionTile(
              title: const Text(
                'Example Sentences',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'LibreFranklin',
                    color: Colors.grey),
              ),
              collapsedIconColor: Colors.grey,
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
