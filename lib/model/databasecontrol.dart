import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/model/config.dart';

class DataBaseIntegration {
  static int requestNumber = 0;
  static int dbSize = 0;

  static Future<List<ResultRow>> fetchDataFromDB(List<String> columns) async {
    requestNumber++;
    print("requests: $requestNumber");

    var settings = ConnectionSettings(
      host: AppConfig.dbHost,
      port: AppConfig.dbPort,
      user: AppConfig.dbUser,
      password: AppConfig.dbPassword,
      db: AppConfig.dbName,
    );

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
}

// add get db size