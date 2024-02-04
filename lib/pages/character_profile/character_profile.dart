// character_profile_page.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:path_provider/path_provider.dart';
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
  Color confidence = Colors.grey;

  @override
  void initState() {
    super.initState();
    getConfidence();
    final characterProfileModel = context.read<CharacterProfileModel>();
    characterProfileModel
        .fetchExampleSentences(widget.selectedCharacter.simplified);
  }

  Future<void> getConfidence() async {
    // Read the JSON file
    int confidenceLevel = 0;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/stats.json';

    File file = File(filePath);
    String jsonString = await file.readAsString();

    // Parse JSON content into a Dart list of maps
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonList);

    // Update the score based on the character
    for (var item in data) {
      if (item['simplified'] == widget.selectedCharacter.simplified) {
        confidenceLevel = item['score'];
        break; // Assuming each character is unique, no need to continue searching
      }
    }

    switch (confidenceLevel) {
      case 0:
        confidence = Colors.red;
        break;
      case 1:
        confidence = Colors.yellow;
        break;
      case 2:
        confidence = Colors.amber;
        break;
      case 3:
        confidence = Colors.lightGreen;
        break;
      case 4:
        confidence = Colors.green;
        break;
      default:
        confidence = Colors.red;
    }

    if (confidenceLevel >= 5) {
      confidence = Colors.blue;
    }
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
                  color: confidence,
                  size: 30,
                ),
              ],
            ),
            // Display other relevant information

            // Example sentences section

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
