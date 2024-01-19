import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/model/config.dart';

class DataBaseIntegration {
  static int requestNumber = 0;

  static Future<List<String>> connectToDB(int counter) async {
    requestNumber++;
    print("requests: $requestNumber");
    List<String> items = ['...', '...', '...'];

    var settings = ConnectionSettings(
      host: AppConfig.dbHost,
      port: AppConfig.dbPort,
      user: AppConfig.dbUser,
      password: AppConfig.dbPassword,
      db: AppConfig.dbName,
    );

    var conn = await MySqlConnection.connect(settings);

    var results = await conn.query('select simplified, pinyin_tones, translation from hsk.vocabulary where id = $counter');

    for (var row in results) {
      items[0] = row[0];
      items[1] = row[1];
      items[2] = row[2];
    }

    await conn.close();
    return items;
  }

  static Future<int> getDBsize() async {
    int size = 0;

    var settings = ConnectionSettings(
      host: AppConfig.dbHost,
      port: AppConfig.dbPort,
      user: AppConfig.dbUser,
      password: AppConfig.dbPassword,
      db: AppConfig.dbName,
    );

    var conn = await MySqlConnection.connect(settings);

    var results = await conn.query('select count(id) from hsk.vocabulary');

    for (var row in results) {
      size = row[0];
    }

    await conn.close();
    return size;
  }
}
