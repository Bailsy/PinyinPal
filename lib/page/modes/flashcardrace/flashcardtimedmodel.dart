// FlashCardTimedModel.dart
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/model/databasecontrol.dart';

class FlashCardTimedModel extends ChangeNotifier {
  int _count = 0;
  double _deviceHeight = 0;
  int _correct = 0;
  int _incorrect = 0;
  String _currHanzi = "";
  String _currTranslation = ""; // Add translation
  int _maxCount = 2;

  int get count => _count;
  double get deviceHeight => _deviceHeight;
  int get correct => _correct;
  int get incorrect => _incorrect;
  String get currentHanzi => _currHanzi;
  String get currTranslation => _currTranslation; // Getter for translation
  int get maxCount => _maxCount;
  List<ResultRow> hsk1data = [];

  // increase correct
  void increaseCorrect() {
    _correct++;
    increaseCount();

    //causes re-render
    notifyListeners();
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

  void nextQuestion() {
    _currHanzi = hsk1data[_count]['simplified'].toString();
    _currTranslation = hsk1data[_count]['translation'].toString();
    print(_currHanzi);
    notifyListeners(); // Notify listeners that the state has changed
  }

  // Initialize data from the database
  Future<void> initializeDataFromDatabase() async {
    _deviceHeight = DeviceInfo.height;
    hsk1data =
        await DataBaseIntegration.fetchDataFromDB(['simplified', 'translation'])
          ..shuffle();
    nextQuestion();
    print(hsk1data[count]);
    notifyListeners();
  }
}
