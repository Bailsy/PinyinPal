// FlashCardTimedModel.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/models/databasecontrol.dart';
//import collectionmodel

class FlashCardTimedModel extends ChangeNotifier {
  int _count = 0;
  double _deviceHeight = 0;
  int _correct = 0;
  int _incorrect = 0;
  String _currHanzi = "";
  String _currTranslation = ""; // Add translation
  final int _maxCount = 5;
  List<ResultRow> _hsk1data = [];

  int get count => _count;
  double get deviceHeight => _deviceHeight;
  int get correct => _correct;
  int get incorrect => _incorrect;
  String get currentHanzi => _currHanzi;
  String get currTranslation => _currTranslation; // Getter for translation
  int get maxCount => _maxCount;
  List<ResultRow> get hsk1data => _hsk1data;

  // increase correct
  void increaseCorrect() {
    _correct++;
    increaseCount();
  }

  // increase incorrect
  void increaseIncorrect() {
    _incorrect++;
    increaseCount();
  }

  void increaseCount() {
    _count++;
  }

  // hanzi getter
  String getCurrHanzi() {
    return _currHanzi;
  }

  // translation getter
  String getCurrTranslation() {
    return _currTranslation;
  }

  Future<void> updateScore() async {
    // Read the JSON file
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/stats.json';

    File file = File(filePath);
    String jsonString = await file.readAsString();

    // Parse JSON content into a Dart list of maps
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonList);

    // Update the score based on the character
    for (var item in data) {
      if (item['simplified'] == hsk1data[_count]['simplified'].toString()) {
        item['score'] = item['score'] + 1;
        break; // Assuming each character is unique, no need to continue searching
      }
    }
    // Write the updated data structure back to the JSON file
    file.writeAsStringSync(jsonEncode(data));
    print(file.readAsString());
  }

  void nextQuestion() {
    _currHanzi = hsk1data[_count]['simplified'].toString();
    _currTranslation = hsk1data[_count]['translation'].toString();
    print('answer: $_currHanzi');

    print(hsk1data);
    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Initialize data from the database
  Future<void> initializeDataFromDatabase() async {
    _deviceHeight = DeviceInfo.height;
    _hsk1data =
        await DataBaseIntegration.fetchDataFromDB(['simplified', 'translation'])
          ..shuffle();
    nextQuestion();
  }
}
