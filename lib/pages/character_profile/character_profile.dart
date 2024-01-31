// character_profile_page.dart
import 'package:flutter/material.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/pages/newhome.dart';

class CharacterProfileBody extends StatelessWidget {
  final HskEntry selectedCharacter;
  const CharacterProfileBody({required this.selectedCharacter});

  @override
  Widget build(BuildContext context) {
    // Use characterProfileProvider to access character profile information
    // Display relevant information on the page

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
        child: Text(
          selectedCharacter.pinyin_tones,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: StylingConstants.pFontSizeMedium,
            fontFamily: StylingConstants.pStandartFont,
            color: Colors.white,
          ),
        ),
        // Display other relevant information
      ),
    );
  }
}
