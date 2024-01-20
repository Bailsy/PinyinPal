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
    db: AppConfig.dbName,
  );

  static Future<List<ResultRow>> fetchDataFromDB(List<String> columns) async {
    requestNumber++;
    print("requests: $requestNumber");
    List<String> items = ['...', '...', '...'];

    var conn = await MySqlConnection.connect(settings);

    try {
      // Form a comma-separated string of column names
      String selectedColumns = columns.join(', ');
      print('select $selectedColumns from hsk.vocabulary');

      var results = await conn.query(
        'select $selectedColumns from hsk.vocabulary',
      );

      print(
          'Data array: ${results.toList()}'); // Add this line to print the entire data array

      return results.toList();
    } finally {
      await conn.close();
    }
  }

  static Future<List> getUserStats() async {
    ProfileModel currentProfile = ProfileModelSingleton().profileModel;
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query(
        "SELECT users.UNAME, profiles.* FROM accounts.users JOIN accounts.profiles ON accounts.users.UID = accounts.profiles.UID WHERE accounts.profiles.UID = " +
            currentProfile.userId.toString());
    await conn.close();
    return results.toList();
  }
}
