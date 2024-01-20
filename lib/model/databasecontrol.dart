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

  static Future<List<String>> connectToDB(int counter) async {
    requestNumber++;
    print("requests: $requestNumber");
    List<String> items = ['...', '...', '...'];

    var conn = await MySqlConnection.connect(settings);

    var results = await conn.query(
        'select simplified, pinyin_tones, translation from hsk.vocabulary where id = $counter');

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

    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select count(id) from hsk.vocabulary');
    for (var row in results) {
      size = row[0];
    }

    await conn.close();
    return size;
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
