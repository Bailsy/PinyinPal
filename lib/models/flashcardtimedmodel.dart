// FlashCardTimedModel.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/databasecontrol.dart';
import 'package:pinyinpal/models/lvl.dart';
//import collectionmodel

class FlashCardTimedModel extends ChangeNotifier {
  int _count = 0;
  double _deviceHeight = 0;
  int _correct = 0;
  int _incorrect = 0;
  String _currHanzi = "";
  String _currTranslation = ""; // Add translation
  final int _maxCount = 5;
  List<dynamic> _hskdata = [];

  int get count => _count;
  double get deviceHeight => _deviceHeight;
  int get correct => _correct;
  int get incorrect => _incorrect;
  String get currentHanzi => _currHanzi;
  String get currTranslation => _currTranslation; // Getter for translation
  int get maxCount => _maxCount;
  List<dynamic> get hskdata => _hskdata;

  // increase correct
  void increaseCorrect() {
    _correct++;
  }

  // increase incorrect
  void increaseIncorrect() {
    _incorrect++;
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
      if (item['simplified'] == _currHanzi) {
        print("we have updated the score for: " + item['simplified']);
        item['score']++;
        break; // Assuming each character is unique, no need to continue searching
      }
    }
    // Write the updated data structure back to the JSON file
    file.writeAsStringSync(jsonEncode(data));
    print(file.readAsString());
  }

  void nextQuestion() {
    _currHanzi = hskdata[_count]['simplified'].toString();
    _currTranslation = hskdata[_count]['translation'].toString();
    print('answer: $_currHanzi');

    print(hskdata);
    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Initialize data from the database
  Future<void> initializeDataFromDatabase() async {
    _deviceHeight = DeviceInfo.height;

    String jsonString = await rootBundle.loadString(HskPath.hskPath);
    List<dynamic> jsonList = json.decode(jsonString);
    _hskdata = jsonList.toList()..shuffle();
    nextQuestion();
  }
}
