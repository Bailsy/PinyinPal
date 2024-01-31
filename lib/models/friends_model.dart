import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/models/profilemodel.dart';

class FriendModel extends ChangeNotifier {
  List<dynamic> _usernames = [];
  List<dynamic> _requests = [];
  List<dynamic> _friends = [];
  String nameSearch = '';

  List<dynamic> get usernames => _usernames;
  List<dynamic> get requests => _requests;
  List<dynamic> get friends => _friends;

  FriendModel() {
    // Initialize the data when the model is created
    loadUsers(nameSearch);
    loadRequests();
    loadFriends();
  }

  Future<void> loadUsers(String nameSearch) async {
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

  Future<void> loadRequests() async {
    try {
      String userUrl = "https://pinyinpal.com/friend_api/list_request.php";
      ProfileModel currentProfile = ProfileModelSingleton().profileModel;
      print(currentProfile.userId.toString());

      var data = {
        'FUID': currentProfile.userId.toString(),
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));

      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);

        //Check Login Status
        if (msg['gotUsernames'] == true && msg['usernames'].length > 0) {
          print('We have the request names');

          _requests = msg['usernames'];
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

  Future<void> loadFriends() async {
    try {
      String userUrl = "https://pinyinpal.com/friend_api/list_friends.php";
      ProfileModel currentProfile = ProfileModelSingleton().profileModel;
      print(currentProfile.userId.toString());

      var data = {
        'FUID': currentProfile.userId.toString(),
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));

      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);

        //Check Login Status
        if (msg['gotUsernames'] == true && msg['usernames'].length > 0) {
          print('We have the friend names');

          print(msg['usernames']);

          _friends = msg['usernames'];
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
