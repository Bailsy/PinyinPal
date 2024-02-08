import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hsk_entry.dart';

class HskPath {
  static String hskPath = 'assets/json/hsk_data2.json';
}

class CollectionModel extends ChangeNotifier {
  List<HskEntry> _hskEntries = [];
  List<HskEntry> get hskEntries => _hskEntries;

  HskEntry? _selectedCharacter;
  HskEntry? get selectedCharacter => _selectedCharacter;

  Future<void> loadCollectionData() async {
    try {
      // Load JSON data from assets
      String jsonString = await rootBundle.loadString(HskPath.hskPath);
      List<dynamic> jsonList = json.decode(jsonString);

      // Convert JSON to a list of HskEntry objects
      _hskEntries = jsonList.map((entryJson) {
        return HskEntry.fromJson(entryJson);
      }).toList();

      print('Loaded ${_hskEntries.length} entries');
      print(_hskEntries);
      // Notify listeners that the data has been loaded
      notifyListeners();
    } catch (e) {
      // Handle errors during data loading
      print('Error loading data: $e');
    }
  }

  void onCharacterTap(HskEntry character) {
    _selectedCharacter = character;
    notifyListeners();
  }

  Color getColor(int confidenceLevel) {
    Color confidence = Colors.grey;
    switch (confidenceLevel) {
      case 0:
        confidence = Colors.red;
        break;
      case 1:
        confidence = Colors.yellow;
        break;
      case 2:
        confidence = Colors.amber;
        break;
      case 3:
        confidence = Colors.lightGreen;
        break;
      case 4:
        confidence = Colors.green;
        break;
      default:
        confidence = Colors.red;
    }

    if (confidenceLevel >= 5) {
      confidence = Colors.blue;
    }

    return confidence;
  }
}
