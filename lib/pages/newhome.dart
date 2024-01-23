import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/pages/home.dart';
import 'package:pinyinpal/pages/modes/flashcardrace/flashcardtimed.dart';
import 'package:pinyinpal/pages/profile.dart';
import 'package:pinyinpal/pages/progression.dart';
import 'package:pinyinpal/pages/userstats.dart';
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
  const NewHomePage({Key? key});
  @override
  NewHomePageState createState() => NewHomePageState();
}

class NewHomePageState extends State<NewHomePage> {
  int indexPos = 0;

  @override
  Widget build(BuildContext context) {
    SystemNav.setNavBar();
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
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
          HomePage(),
          FlashCardTimed(),
          ProgressionPage(),
          UserStats(),
        ],
      ),
    );
  }
}
