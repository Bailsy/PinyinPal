import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/page/modes/flashcardrace/flashcardtimed.dart';
import 'package:pinyinpal/page/profile.dart';

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
            Align(
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FlashCardTimed()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
