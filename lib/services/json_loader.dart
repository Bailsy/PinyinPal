import 'package:flutter/services.dart';

class JsonLoader {
  static Future<String> loadJson(String path) async {
    return await rootBundle.loadString(path);
  }
}
