import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheLogin {
  static final storage = const FlutterSecureStorage();

  static void saveCredentials(String username, String password) async {
    await storage.write(key: "username", value: username);
    await storage.write(key: "password", value: password);
  }

  static Future<List<String>> retrieveCredentials() async {
    String username = await storage.read(key: 'username') ?? '';
    String password = await storage.read(key: 'password') ?? '';

    if (username.isEmpty || password.isEmpty) {
      return [];
    }

    print('Retrieved Username: $username');
    print('Retrieved Password: $password');
    return [username, password];
  }

  static Future<bool> credentialsExist() async {
    String username = await storage.read(key: 'username') ?? '';
    String password = await storage.read(key: 'password') ?? '';

    return username != null && password != null;
  }

  static Future<void> deleteCredentials() async {
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
    print('Credentials deleted');
  }
}
