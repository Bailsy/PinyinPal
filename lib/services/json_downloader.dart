import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/models/profilemodel.dart';

class DownloadJson {
  Future<void> downloadJson() async {
    try {
      String userUrl = "https://pinyinpal.com/stats_api/download_stats.php";
      ProfileModel currentProfile = ProfileModelSingleton().profileModel;
      print(currentProfile.userId.toString());

      var data = {
        'UID': currentProfile.userId.toString(),
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));

      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['requestStatus'] == true) {
          print('Successfully downloaded Stats');
          // Get the ApplicationDocumentsDirectory
          Directory appDocumentsDir = await getApplicationDocumentsDirectory();

          // Create a new file in the ApplicationDocumentsDirectory

          File newFile = File('${appDocumentsDir.path}/stats.json');
          List<dynamic> jsonList = jsonDecode(msg['stats']['json_data']);
          List<Map<String, dynamic>> dataList =
              List<Map<String, dynamic>>.from(jsonList);
          print(dataList);

          // Write JSON string to the file
          await newFile.writeAsString(msg['stats']['json_data']);
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
