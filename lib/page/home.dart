import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/imagepaths.dart';
import 'package:pinyinpal/page/modes/flashcardrace/flashcardtimed.dart';
import 'package:pinyinpal/page/profile.dart';
import 'package:pinyinpal/page/progression.dart';
import 'package:pinyinpal/page/userstats.dart';
import 'package:pinyinpal/widget/bottomnavbar.dart';
import 'package:pinyinpal/widget/homebutton.dart';

class SystemNav {
  static void setNavBar() {
    var mySystemTheme = SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: Colors.black);

    //SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
}

class HomePage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const HomePage({Key? key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FlashCardTimed(),
    ProgressionPage(),
    UserStats()
  ];
  @override
  Widget build(BuildContext context) {
    SystemNav.setNavBar();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                bottom: DeviceInfo.physicalHeight / 6, left: 60, right: 60),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: SvgPicture.asset(assetName),
                  height: 400,
                )),
          ),
          Container(
            padding: EdgeInsets.only(
                top: DeviceInfo.physicalHeight / 20, left: 20, right: 20),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                child: Neon(
                  text: 'PinYin Pal',
                  color: Colors.blue,
                  fontSize: 55,
                  font: NeonFont.Beon,
                  flickeringText: false,
                  flickeringLetters: null,
                  glowingDuration: new Duration(seconds: 1),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
