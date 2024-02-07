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
  late CharacterProfileModel characterProfileModel;

  @override
  void initState() {
    super.initState();

    // Load the data
    characterProfileModel = context.read<CharacterProfileModel>();
  }

  @override
  Widget build(BuildContext context) {
    final character = characterProfileModel.character;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  character.simplified,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: StylingConstants.pFontSizeLarge,
                    fontFamily: StylingConstants.pStandartFont,
                    color: characterProfileModel.confidence,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0), // Adjust the padding as needed
                      child: ElevatedButton(
                        onPressed: () => characterProfileModel
                            .playAudio(character.simplified),
                        child: const Iconify(
                          Ph.speaker_high_fill,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Add the character's pinyin
            Text(
              character.pinyin_tones,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: StylingConstants.pStandartFont,
                color: Colors.grey,
              ),
            ),
            Container(height: 30),
            // Add the character's translation
            Text(
              character.translation,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: StylingConstants.pStandartFont,
                color: Colors.white,
              ),
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
