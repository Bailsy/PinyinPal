import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/model/config.dart';
import 'package:pinyinpal/model/profilemodel.dart';

class DataBaseIntegration {
  static int requestNumber = 0;

  static var settings = ConnectionSettings(
    host: AppConfig.dbHost,
    port: AppConfig.dbPort,
    user: AppConfig.dbUser,
    password: AppConfig.dbPassword,
  );

  static Future<List<ResultRow>> fetchDataFromDB(List<String> columns) async {
    requestNumber++;
    print("requests: $requestNumber");

    var conn = await MySqlConnection.connect(settings);

    try {
      // Form a comma-separated string of column names
      String selectedColumns = columns.join(', ');
      print('select $selectedColumns from hsk.vocabulary');

      var results = await conn.query(
        'select $selectedColumns from hsk.vocabulary',
      );

      return results.toList();
    } finally {
      await conn.close();
    }
  }

  static Future<List> getUserStats(String userId) async {
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        "SELECT users.UNAME, profiles.* FROM accounts.users JOIN accounts.profiles ON accounts.users.UID = accounts.profiles.UID WHERE accounts.profiles.UID = " +
            userId);
    await conn.close();
    return results.toList();
  }

  static void updateXP(int experience) async {
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;
    var conn = await MySqlConnection.connect(settings);
    await conn.query(
        "UPDATE accounts.profiles SET XP = XP + $experience WHERE UID = " +
            currentProfile.userId.toString());
    await conn.close();
  }
}
