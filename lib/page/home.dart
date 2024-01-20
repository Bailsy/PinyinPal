import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/page/flashcardtimed.dart';
import 'package:pinyinpal/page/profile.dart';
import 'package:pinyinpal/page/progression.dart';

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
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: pGreyColour,
              ),
            ),
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
                padding: EdgeInsets.only(
                    top: DeviceInfo.physicalHeight / 80, left: 60, right: 60),
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 300.0,
                      maxWidth: 300.0,
                      minHeight: DeviceInfo.physicalHeight / 30,
                      maxHeight: DeviceInfo.physicalHeight / 25,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pLightGreyColour,
                      ),
                      child: InkWell(
                        child: Neon(
                          text: "Flashcards|抽认卡",
                          color: Colors.blue,
                          font: NeonFont.Beon,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FlashCardTimed()));
                      },
                    ),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(
                    top: DeviceInfo.physicalHeight / 9, left: 60, right: 60),
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 300.0,
                      maxWidth: 300.0,
                      minHeight: DeviceInfo.physicalHeight / 30,
                      maxHeight: DeviceInfo.physicalHeight / 25,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pLightGreyColour,
                      ),
                      child: InkWell(
                        child: Neon(
                          text: "Lessons|课程",
                          color: Colors.blue,
                          font: NeonFont.Beon,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProgressionPage()));
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
