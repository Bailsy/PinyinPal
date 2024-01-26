import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/models/databasecontrol.dart';
import 'hsk_entry.dart';
import 'package:http/http.dart' as http;

class FriendModel extends ChangeNotifier {
  List<dynamic> _usernames = [];
  String nameSearch = '';

  List<dynamic> get usernames => _usernames;

  FriendModel() {
    // Initialize the data when the model is created
    loadData(nameSearch);
  }

  Future<void> loadData(String nameSearch) async {
    try {
      String userUrl = "https://pinyinpal.com/friend_api/list_users.php";

      var data = {
        'username': nameSearch,
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));
      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['gotUsernames'] == true && msg['usernames'].length > 0) {
          print('We have the usernames');

          _usernames = msg['usernames'];
        } else {
          print(msg["message"]);
        }
      }

      // Convert JSON to a list of HskEntry objects
      notifyListeners();
    } catch (e) {
      // Handle errors during data loading
      print('Error loading data: $e');
    }
  }
}
