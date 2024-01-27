// character_profile_page.dart
import 'package:flutter/material.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/providers/character_profile_provider.dart';
import 'package:provider/provider.dart';

class CharacterProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HskEntry selectedCharacter =
        context.read<CollectionModel>().selectedCharacter!;

    return ChangeNotifierProvider(
      create: (_) => CharacterProfileProvider(),
      child: CharacterProfileBody(selectedCharacter: selectedCharacter),
    );
  }
}

class CharacterProfileBody extends StatelessWidget {
  final HskEntry selectedCharacter;

  // init data from provider

  const CharacterProfileBody({required this.selectedCharacter});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProfileProvider>(
      builder: (context, characterProfileProvider, child) {
        // Use characterProfileProvider to access character profile information
        // Display relevant information on the page

        return Scaffold(
          appBar: AppBar(
            title: Text(selectedCharacter.simplified),
          ),
          body: Center(
            child: Text(characterProfileProvider.characterProfileModel.pinyin),
            // Display other relevant information
          ),
        );
      },
    );
  }
}
