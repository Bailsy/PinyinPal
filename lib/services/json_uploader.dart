import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/models/profilemodel.dart';

class UploadJson {
  Future<void> uploadStats() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDirectory.path}/stats.json';
      String userUrl = "https://pinyinpal.com/stats_api/update_stats.php";

      File file = File(filePath);
      String jsonString = await file.readAsString();

      ProfileModel currentProfile = ProfileModelSingleton().profileModel;

      var data = {
        'UID': currentProfile.userId.toString(),
        'json_data': jsonString
      };
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));
      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['requestStatus'] == true) {
          print('Successfully uploaded Stats');
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
