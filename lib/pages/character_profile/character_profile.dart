import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/character_profile_model.dart';
import 'package:provider/provider.dart';

class CharacterProfilePage extends StatelessWidget {
  const CharacterProfilePage({super.key});

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
      body: const CharacterProfileBody(),
    );
  }
}

class CharacterProfileBody extends StatefulWidget {
  const CharacterProfileBody({super.key});

  @override
  _CharacterProfileBodyState createState() => _CharacterProfileBodyState();
}

class _CharacterProfileBodyState extends State<CharacterProfileBody> {
  @override
  void initState() {
    super.initState();

    // Load the data
    final characterProfileModel = context.read<CharacterProfileModel>();
  }

  @override
  Widget build(BuildContext context) {
    final characterProfileModel = context.watch<CharacterProfileModel>();
    final character = characterProfileModel.character;

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
                  characterProfileModel.character.simplified,
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
                  onPressed: () => characterProfileModel.playAudio(character),
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
                  color: characterProfileModel.confidence,
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
                    character.translation,
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
                  children: characterProfileModel.character.exampleSentences
                      .map((examplesentence) => ListTile(
                            title: Text(examplesentence.sentence),
                            textColor: Colors.white,
                            subtitle: Text(examplesentence.translation),
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
