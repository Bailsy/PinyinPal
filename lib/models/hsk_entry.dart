class HskEntry {
  final String simplified;
  final String pinyin_tones;
  final String translation;

  HskEntry({
    required this.simplified,
    required this.pinyin_tones,
    required this.translation,
  });

  factory HskEntry.fromJson(Map<String, dynamic> json) {
    return HskEntry(
      simplified: json['simplified'],
      pinyin_tones: json['pinyin_tones'],
      translation: json['translation'],
    );
  }
}
