import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinyinpal/models/profilemodel.dart';

class SendFriendRequest {
  Future<void> sendRequest(String friendID) async {
    try {
      String userUrl = "https://pinyinpal.com/friend_api/request_friend.php";

      ProfileModel currentProfile = ProfileModelSingleton().profileModel;

      var data = {
        'UID': currentProfile.userId.toString(),
        'FUID': friendID.toString()
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));
      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['requestStatus'] == true) {
          print('Request Successful');
        } else {
          print(msg["message"]);
        }
      }
    } catch (e) {
      // Handle errors during data loading
      print('Error loading data: $e');
    }
  }

  Future<void> acceptRequest(String friendID) async {
    try {
      String userUrl = "https://pinyinpal.com/friend_api/accept_request.php";

      ProfileModel currentProfile = ProfileModelSingleton().profileModel;

      var data = {
        'UID': currentProfile.userId.toString(),
        'FUID': friendID.toString()
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));
      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['requestStatus'] == true) {
          print('Successfully Accepted');
        } else {
          print(msg["message"]);
        }
      }
    } catch (e) {
      // Handle errors during data loading
      print('Error loading data: $e');
    }
  }

  Future<void> denyRequest(String friendID) async {
    try {
      String userUrl = "https://pinyinpal.com/friend_api/deny_request.php";

      ProfileModel currentProfile = ProfileModelSingleton().profileModel;

      var data = {
        'UID': currentProfile.userId.toString(),
        'FUID': friendID.toString()
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));
      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['requestStatus'] == true) {
          print('Successfully denied');
        } else {
          print(msg["message"]);
        }
      }
    } catch (e) {
      // Handle errors during data loading
      print('Error loading data: $e');
    }
  }
}
