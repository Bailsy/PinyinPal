import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pinyinpal/constants/themes.dart';
import 'package:pinyinpal/page/home.dart';
import 'package:pinyinpal/page/profile.dart';
import 'package:pinyinpal/page/login.dart';
import 'package:pinyinpal/model/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await AppConfig.setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
