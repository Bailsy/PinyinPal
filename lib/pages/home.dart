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
        ],
      ),
    );
  }
}
