import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/models/databasecontrol.dart';
import 'hsk_entry.dart';

class FriendModel extends ChangeNotifier {
  List<dynamic> _usernames = [];

  List<dynamic> get usernames => _usernames;

  FriendModel() {
    // Initialize the data when the model is created
    loadData();
  }

  Future<void> loadData() async {
    try {
      Future<List<dynamic>> futureList = DataBaseIntegration.getUsernames();
      List<dynamic> normalList = await futureList;

      _usernames = normalList;
      print(normalList);
      // Convert JSON to a list of HskEntry objects

      notifyListeners();
    } catch (e) {
      // Handle errors during data loading
      print('Error loading data: $e');
    }
  }
}
