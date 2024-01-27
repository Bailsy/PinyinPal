import 'dart:typed_data';

class CharacterProfileModel {
  final String character;
  final String pinyin;
  final Uint8List audioData;
  final String meaning;
  final List<ExampleSentence> exampleSentences;

  CharacterProfileModel({
    required this.character,
    required this.pinyin,
    required this.audioData,
    required this.meaning,
    required this.exampleSentences,
  });
}

class ExampleSentence {
  final String hanzi;
  final String pinyin;
  final String translation;
  final String level;
  final Uint8List audioData;

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
