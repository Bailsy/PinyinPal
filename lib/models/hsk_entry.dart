class HskEntry {
  final String simplified;
  final String pinyin_tones;
  final String translation;
  final List<ExampleSentence> exampleSentences;

  HskEntry({
    required this.simplified,
    required this.pinyin_tones,
    required this.translation,
    required this.exampleSentences,
  });

  factory HskEntry.fromJson(Map<String, dynamic> json) {
    return HskEntry(
      simplified: json['simplified'],
      pinyin_tones: json['pinyin_tones'],
      translation: json['translation'],
      exampleSentences: json['examples']
          .map<ExampleSentence>(
              (sentence) => ExampleSentence.fromJson(sentence))
          .toList(),
    );
  }
}

class ExampleSentence {
  final String sentence;
  final String translation;

  ExampleSentence({
    required this.sentence,
    required this.translation,
  });

  factory ExampleSentence.fromJson(Map<String, dynamic> json) {
    return ExampleSentence(
      sentence: json['sentence'],
      translation: json['translation'],
    );
  }
}
