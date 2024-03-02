import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/pages/games/flashcard/finishedset.dart';

class DownloadJson {
  Future<void> downloadJson(String hsklvl, String userId) async {
    try {
      String userUrl = "https://pinyinpal.com/stats_api/download_stats.php";

      var data = {'UID': userId, 'HSK': hsklvl};
      var response =
          await http.post(Uri.parse(userUrl), body: json.encode(data));

      if (response.statusCode == 200) {
        //Server response into variable
        var msg = jsonDecode(response.body);
        //Check Login Status
        if (msg['requestStatus'] == true) {
          print('Successfully downloaded Stats');
          // Get the ApplicationDocumentsDirectory

          CardTotals.correct = int.parse(msg['stats']['correct']);
          CardTotals.incorrect = int.parse(msg['stats']['incorrect']);

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
