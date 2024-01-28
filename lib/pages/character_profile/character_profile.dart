// character_profile_page.dart
import 'package:flutter/material.dart';
import 'package:pinyinpal/constants/stylingconstants.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/providers/character_profile_provider.dart';
import 'package:provider/provider.dart';

class CharacterProfileBody extends StatelessWidget {
  final HskEntry selectedCharacter;

  // init data from provider

  const CharacterProfileBody({required this.selectedCharacter});

  @override
  Widget build(BuildContext context) {
    // Use characterProfileProvider to access character profile information
    // Display relevant information on the page

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCharacter.simplified),
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
