import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/models/profilemodel.dart';

class DownloadJson {
  Future<void> downloadJson(String hsklvl) async {
    try {
      String userUrl = "https://pinyinpal.com/stats_api/download_stats.php";
      ProfileModel currentProfile = ProfileModelSingleton().profileModel;
      print(currentProfile.userId.toString());

      var data = {'UID': currentProfile.userId.toString(), 'HSK': hsklvl};
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
          File newFile = File('${appDocumentsDir.path}/stats.json');
          await newFile.writeAsString(msg['stats'][hsklvl]);
          print("here is what we have: " + msg['stats'][hsklvl]);
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
