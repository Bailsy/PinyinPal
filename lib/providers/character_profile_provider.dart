import 'package:flutter/material.dart';
import 'package:pinyinpal/models/character_profile_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/services/api_service.dart';

class CharacterProfileProvider extends ChangeNotifier {
  late CharacterProfileModel _characterProfileModel;

  CharacterProfileModel get characterProfileModel => _characterProfileModel;

  Future<void> fetchData(HskEntry hskEntry) async {
    final audioData = await ApiService.fetchAudioData(hskEntry.simplified);
    final exampleSentences = await ApiService.fetchExampleSentences(
        hskEntry.simplified, 'Elementary');

    _characterProfileModel = CharacterProfileModel(
      character: hskEntry.simplified,
      pinyin: hskEntry
          .pinyin_tones, // You need to replace this with the actual pinyin.a
      audioData: audioData,
      meaning: hskEntry
          .translation, // You need to replace this with the actual meaning.
      exampleSentences: exampleSentences,
    );
  }
}
