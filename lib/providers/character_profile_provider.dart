import 'package:flutter/material.dart';
import 'package:pinyinpal/models/character_profile_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/pages/character_profile/character_profile.dart';
import 'package:provider/provider.dart';

class CharacterProfileProvider extends StatelessWidget {
  final HskEntry hskCharacter; // Add this line

  const CharacterProfileProvider({Key? key, required this.hskCharacter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Provider to provide the CharacterProfileModel to the widget tree
    return ChangeNotifierProvider(
      create: (_) => CharacterProfileModel(),
      child: CharacterProfilePage(
          selectedCharacter: hskCharacter), // Pass the HskCharacter
    );
  }
}
