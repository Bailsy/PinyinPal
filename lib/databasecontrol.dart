import 'package:mysql1/mysql1.dart';

class DataBaseIntegration {

  static int requestNumber = 0;

  static var settings = ConnectionSettings(
    host: 'mydatabase.cr8csc4s4i51.eu-north-1.rds.amazonaws.com',
    port: 3306,
    user: 'admin',
    password: '******',
    db: 'hsk',
  );

  static Future<List> connectToDB(int counter) async {
    requestNumber++;
    print("requests: " + (requestNumber).toString());
    List<String> items = ['...', '...', '...'];
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select simplified, pinyin_tones, translation from hsk.vocabulary where id = ' + counter.toString());
    for (var row in results) {
      items[0] = row[0];
      items[1] = row[1];
      items[2] = row[2];
    }
    ;
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
    ;
    await conn.close();
    return size;
  }
}