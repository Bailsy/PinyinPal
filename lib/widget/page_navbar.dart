import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinyinpal/pages/stats/stats.dart';
import 'package:pinyinpal/providers/collection_provider.dart';
import 'package:pinyinpal/pages/profile/profile.dart';
import 'package:pinyinpal/pages/games/select_page.dart';
import 'package:pinyinpal/widget/page_navbar_icons.dart';

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
  int indexPos = 1;

  @override
  Widget build(BuildContext context) {
    SystemNav.setNavBar();
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        startPos: 1,
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
          SelectPage(),
          CollectionProvider(),
          UserStats(),
        ],
      ),
    );
  }
}
