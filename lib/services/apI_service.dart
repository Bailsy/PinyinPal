import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/models/character_profile_model.dart';

class ApiService {
  static Future<Uint8List> fetchAudioData(String hanzi) async {
    final response = await http
        .get(Uri.parse('https://pinyin-word-api.vercel.app/api/audio/$hanzi'));
    // Process the response and convert it to Uint8List

    // Placeholder: Handle the response and return a Uint8List
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      // Handle error case
      return Future.error('Error fetching audio data');
    }
  }

  static Future<List<ExampleSentence>> fetchExampleSentences(
      String word) async {
    final response = await http.get(
        Uri.parse('https://pinyin-word-api.vercel.app/api/sentences/$word'));
    // Process the response and convert it to List<ExampleSentence>

    // Placeholder: Handle the response and return a List<ExampleSentence>
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<ExampleSentence> exampleSentences =
          data.map((item) => ExampleSentence.fromJson(item)).toList();
      return exampleSentences;
    } else {
      // Handle error case
      return Future.error('Error fetching example sentences');
    }
  }
}
