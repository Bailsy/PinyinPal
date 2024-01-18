import 'package:flutter_config/flutter_config.dart';

class AppConfig {
  static Future<void> setup() async {
    await FlutterConfig.loadEnvVariables();
  }

  static String get dbHost => FlutterConfig.get('DB_HOST')!;
  static int get dbPort => int.parse(FlutterConfig.get('DB_PORT')!);
  static String get dbUser => FlutterConfig.get('DB_USER')!;
  static String get dbPassword => FlutterConfig.get('DB_PASSWORD')!;
  static String get dbName => FlutterConfig.get('DB_NAME')!;
}
