import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/services/apI_service.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:convert';

class CharacterProfileModel extends ChangeNotifier {
  late HskEntry _character;
  HskEntry get character => _character;

  late Color _confidence;
  Color get confidence => _confidence;

  Uint8List audioData = Uint8List(0);

  CharacterProfileModel(
      {required HskEntry hskCharacter, required Color confidence}) {
    _character = hskCharacter;
    _confidence = confidence;
  }

  // Function to play audio for the selected character
  void playAudio(HskEntry character) async {
    try {
      audioData = await ApiService.fetchAudioData(character.simplified);
      //play audio
      final player = AudioPlayer();
      final duration = player.setAudioSource(MyCustomSource(audioData));
      player.setVolume(1000000);
      player.play();
    } catch (error) {
      // Handle error
      print('Error fetching audio data: $error');
    }
  }
}

class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}

class ExampleSentence {
  final String hanzi;
  final String pinyin;
  final String translation;
  final String level;
  final String audioData;

  ExampleSentence({
    required this.hanzi,
    required this.pinyin,
    required this.translation,
    required this.level,
    required this.audioData,
  });

  factory ExampleSentence.fromJson(Map<String, dynamic> json) {
    return ExampleSentence(
      hanzi: json['hanzi'],
      pinyin: json['pinyin'],
      translation: json['translation'],
      level: json['level'],
      audioData: json['audio'],
    );
  }
}
