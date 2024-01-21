import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/page/home.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'package:iconify_flutter/icons/ion.dart';

class Lesson1 extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const Lesson1({Key? key});

  @override
  Lesson1State createState() => Lesson1State();
}

class Lesson1State extends State<Lesson1> {
  @override
  void initState() {
    super.initState();
    countScore();
  }

  String highlighted = "";
  String textRight = "";
  String textLeft = "";

  String highlighted2 = "";
  String textRight2 = "";
  String textLeft2 = "";

  String currentIcon = "";
  String phrase = "现在我在商店 这是很酷";
  String phrase2 = "Now I am in the store. This is cool";

  String getLeftPart(String input, String substring, int occurrenceIndex) {
    int index = -1;
    for (int i = 0; i < occurrenceIndex; i++) {
      index = input.indexOf(substring, index + 1);
      if (index == -1) {
        break; // Stop if the specified occurrence is not found
      }
    }
    return index != -1 ? input.substring(0, index) : input;
  }

  String getRightPart(String input, String substring, int occurrenceIndex) {
    int index = -1;
    for (int i = 0; i < occurrenceIndex; i++) {
      index = input.indexOf(substring, index + 1);
      if (index == -1) {
        break; // Stop if the specified occurrence is not found
      }
    }
    return index != -1 ? input.substring(index + substring.length) : '';
  }

  void stringSplitterChinese(String current) async {
    setState(() {
      highlighted = current;
    });
    setState(() {
      textRight = getRightPart(phrase, highlighted, 1);
    });
    setState(() {
      textLeft = getLeftPart(phrase, highlighted, 1);
    });
  }

  void stringSplitterEnglish(String current) async {
    setState(() {
      highlighted2 = current;
    });
    setState(() {
      textRight2 = getRightPart(phrase2, highlighted2, 1);
    });
    setState(() {
      textLeft2 = getLeftPart(phrase2, highlighted2, 1);
    });
  }

  void iconChanger(String iconName) async {
    setState(() {
      currentIcon = iconName;
    });
  }

  //现在我商店！ 这是很酷
  void countScore() async {
    stringSplitterChinese("现在");
    stringSplitterEnglish("Now");
    iconChanger(Ion.watch);
    await Future.delayed(Duration(seconds: 1));
    stringSplitterChinese("我在");
    stringSplitterEnglish("I am in");
    iconChanger(MaterialSymbols.arrow_downward);
    await Future.delayed(Duration(seconds: 1));
    stringSplitterChinese("商店");
    stringSplitterEnglish("the store");
    iconChanger(Ion.storefront);
    await Future.delayed(Duration(seconds: 1));
    iconChanger(Ph.dots_three);
    stringSplitterChinese("这是");
    stringSplitterEnglish("This is");
    await Future.delayed(Duration(seconds: 1));
    stringSplitterChinese("很酷");
    stringSplitterEnglish("cool");
    iconChanger(Ion.glasses);
    await Future.delayed(Duration(seconds: 1));
  }

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
            Container(
                child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300.0,
                maxWidth: 300.0,
                minHeight: 30.0,
                maxHeight: 100.0,
              ),
              child: const Text(
                "PinYin Basics\n拼音基础 ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'LibreFranklin',
                    color: Colors.grey),
              ),
            )),
            Container(
                child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300.0,
                maxWidth: 300.0,
                minHeight: 30.0,
                maxHeight: 100.0,
              ),
              child: Iconify(
                currentIcon,
                color: Colors.blue,
                size: 100,
              ),
            )),
            Container(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: const Divider(color: Colors.grey),
            ),
            Container(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 300.0,
                      maxWidth: 300.0,
                      minHeight: 30.0,
                      maxHeight: 100.0,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: textLeft,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'LibreFranklin',
                                  color: Colors.grey)),
                          TextSpan(
                              text: highlighted,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'LibreFranklin',
                                  color: Colors.blue)),
                          TextSpan(
                              text: textRight,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'LibreFranklin',
                                  color: Colors.grey)),
                        ],
                      ),
                    ))),
            Container(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 300.0,
                      maxWidth: 300.0,
                      minHeight: 30.0,
                      maxHeight: 100.0,
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: textLeft2,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'LibreFranklin',
                                  color: Colors.grey)),
                          TextSpan(
                              text: highlighted2,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'LibreFranklin',
                                  color: Colors.blue)),
                          TextSpan(
                              text: textRight2,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'LibreFranklin',
                                  color: Colors.grey)),
                        ],
                      ),
                    ))),
          ],
        )));
  }
}
