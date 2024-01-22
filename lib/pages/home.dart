import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:provider/provider.dart';

//Pages
import 'package:pinyinpal/pages/modes/flashcardrace/flashcardtimed.dart';
import 'package:pinyinpal/pages/profile.dart';
import 'package:pinyinpal/pages/progression.dart';
import 'package:pinyinpal/pages/collection/collection_page.dart';
import 'package:pinyinpal/pages/userstats.dart';

//Providers
import 'package:pinyinpal/providers/collection_provider.dart';

//Models
import 'package:pinyinpal/models/collection_model.dart';

//Widgets
import 'package:pinyinpal/widget/homebutton.dart';

//Constants

import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/constants/imagepaths.dart';

class HomePage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const HomePage({Key? key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: const Icon(LineAwesomeIcons.user)),
      ),
      body: Stack(
        children: <Widget>[
          // SVG Picture
          Container(
            padding: EdgeInsets.only(
                bottom: DeviceInfo.physicalHeight / 4.5, left: 60, right: 60),
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: SvgPicture.asset(assetName),
                  height: 300,
                )),
          ),

          // Neon Text
          Container(
            padding: EdgeInsets.only(
                bottom: DeviceInfo.physicalHeight / 8, left: 60, right: 60),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                child: Neon(
                  text: 'PinYin Pal',
                  color: Colors.blue,
                  fontSize: 40,
                  font: NeonFont.Beon,
                  flickeringText: false,
                  flickeringLetters: null,
                  glowingDuration: new Duration(seconds: 1),
                ),
                onTap: () {},
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: DeviceInfo.height / 3),
            child: Column(
              children: <Widget>[
                HomeButton(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FlashCardTimed()));
                    },
                    buttonText: "flashcards - 抽认卡"),
                HomeButton(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProgressionPage()));
                    },
                    buttonText: "lessons - 课程"),
                HomeButton(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                    create: (_) => CollectionModel(),
                                    child: const CollectionPage(),
                                  )));
                    },
                    buttonText: "Collection - 收藏"),
                HomeButton(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserStats()));
                    },
                    buttonText: "stats - 用户统计")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
