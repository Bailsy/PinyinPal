import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinyinpal/pages/userstats.dart';
import 'package:pinyinpal/pages/productivescroll.dart';
import 'package:pinyinpal/providers/collection_provider.dart';
import 'package:pinyinpal/providers/flashcardspoken_provider.dart';
import 'package:pinyinpal/providers/flashcardtimed_provider.dart';
import 'package:pinyinpal/widget/bottomnavbar.dart';

class SystemNav {
  static void setNavBar() {
    var mySystemTheme = SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.black);
    //SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
}

class NewHomePage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const NewHomePage({super.key});
  @override
  NewHomePageState createState() => NewHomePageState();
}

class NewHomePageState extends State<NewHomePage> {
  int indexPos = 2;

  @override
  Widget build(BuildContext context) {
    SystemNav.setNavBar();
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        startPos: 2,
        onIndexChanged: (index) {
          setState(() {
            indexPos = index;
            print(indexPos);
          });
        },
      ),
      body: IndexedStack(
        index: indexPos,
        children: const [
          PreloadPageViewDemo(),
          FlashCardTimedProvider(),
          CollectionProvider(),
          FlashCardSpokenProvider(),
          UserStats(),
        ],
      ),
    );
  }
}
