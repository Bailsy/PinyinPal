import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';
import 'package:pinyinpal/page/flashcardtimed.dart';
import 'package:pinyinpal/page/home.dart';
import 'package:pinyinpal/widget/arrow.dart';
import 'package:pinyinpal/widget/lessonbutton.dart';

class ProgressionPage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const ProgressionPage({Key? key});

  @override
  ProgressionPageState createState() => ProgressionPageState();
}

class ProgressionPageState extends State<ProgressionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Container(
                    child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 300.0,
                    maxWidth: 300.0,
                    minHeight: 30.0,
                    maxHeight: 100.0,
                  ),
                  child: const Text(
                    "Rookie | 菜鸟 ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'LibreFranklin',
                        color: Colors.grey),
                  ),
                ))),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: const Divider(color: Colors.grey),
            ),
            LessonButton(
              text: "PinYin Basics",
              textColor: Colors.blue,
              borderColor: Colors.blue,
              isAnimated: true,
              onPress: () {
                print("Pressed");
              },
            ),
            Arrow(arrowColor: Colors.blue),
            LessonButton(
              text: "Tones",
              textColor: Colors.grey,
              borderColor: Colors.grey,
              isAnimated: false,
              onPress: () {
                print("Pressed");
              },
            ),
            Arrow(arrowColor: Colors.grey),
            LessonButton(
              text: "Greetings",
              textColor: Colors.grey,
              borderColor: Colors.grey,
              isAnimated: false,
              onPress: () {
                print("Pressed");
              },
            ),
            Arrow(arrowColor: Colors.grey),
            LessonButton(
              text: "Thank you!",
              textColor: Colors.grey,
              borderColor: Colors.grey,
              isAnimated: false,
              onPress: () {
                print("Pressed");
              },
            ),
            Arrow(arrowColor: Colors.grey),
            LessonButton(
              text: "What's your name?",
              textColor: Colors.grey,
              borderColor: Colors.grey,
              isAnimated: false,
              onPress: () {
                print("Pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
