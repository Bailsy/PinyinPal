import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pinyinpal/constants/themes.dart';
import 'package:pinyinpal/models/config.dart';
import 'package:pinyinpal/pages/home.dart';
import 'package:pinyinpal/pages/login.dart';
import 'package:pinyinpal/pages/newhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await AppConfig.setup();
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
