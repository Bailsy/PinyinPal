import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/pages/games/flashcard/finishedset.dart';
import 'package:pinyinpal/pages/profile/profile.dart';
import 'package:pinyinpal/widget/piechart.dart';

class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  UserStatsState createState() => UserStatsState();
}

class UserStatsState extends State<UserStats> {
  ProfileModel currentProfile = ProfileModelSingleton().profileModel;
  int indexPos = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center the children vertically
        children: <Widget>[
          Container(
            height: 50,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 30,
              ),
              const Text(
                "Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'LibreFranklin',
                  color: Colors.white,
                ),
              ),
              Container(
                width: 180,
              ),
              IconButton(
                icon: const Icon(
                  LineAwesomeIcons.bars,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                      //here we pass in the reload page void call back so we can update the collection page
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: GlassmorphicContainer(
              height: 250,
              width: 300,
              borderRadius: 7,
              border: 0.8,
              blur: 7,
              alignment: Alignment.center,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    pColorDarkGreyBlue.withAlpha(20),
                    pColorDarkGreyBlue
                  ],
                  stops: [
                    0.3,
                    1,
                  ]),
              borderGradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    pColorWhite.withAlpha(10),
                    pColorWhite.withAlpha(55),
                    pColorWhite.withAlpha(10),
                  ],
                  stops: [
                    // 0,
                    // 0.6,
                    // 1
                    //opposite corners of that above
                    0,
                    0.6,
                    1
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "http://pinyinpal.com/logo.png",
                          ),
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: 0.7,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.blue,
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10), // Add spacing between the image and the text
                  Text(
                    currentProfile.experience.toString() + "xp",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'LibreFranklin',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
          ),
          //! put that in a widget
          GlassmorphicContainer(
              height: 300,
              width: 300,
              borderRadius: 7,
              border: 0.8,
              blur: 7,
              alignment: Alignment.center,
              linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    pColorDarkGreyBlue.withAlpha(20),
                    pColorDarkGreyBlue
                  ],
                  stops: const [
                    0.3,
                    1,
                  ]),
              borderGradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    pColorWhite.withAlpha(10),
                    pColorWhite.withAlpha(55),
                    pColorWhite.withAlpha(10),
                  ],
                  stops: const [
                    0,
                    0.6,
                    1
                  ]),
              child: Column(
                children: <Widget>[
                  MyIconWidget(increment: setIndex),
                  Container(
                    height: 30,
                  ),
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 150.0,
                        maxWidth: 250.0,
                        minHeight: 100.0,
                        maxHeight: 200.0,
                      ),
                      child: IndexedStack(
                        index: indexPos,
                        children: [StatsChart(), StatsBarChart()],
                      )),
                ],
              )),

          Container(
            height: 30,
          ),

          GlassmorphicContainer(
            height: 300,
            width: 300,
            borderRadius: 7,
            border: 0.8,
            blur: 7,
            alignment: Alignment.center,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  pColorDarkGreyBlue.withAlpha(20),
                  pColorDarkGreyBlue
                ],
                stops: const [
                  0.3,
                  1,
                ]),
            borderGradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  pColorWhite.withAlpha(10),
                  pColorWhite.withAlpha(55),
                  pColorWhite.withAlpha(10),
                ],
                stops: const [
                  0,
                  0.6,
                  1
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Total Stats",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: 'LibreFranklin',
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Row(children: [
                  Container(
                    width: 30,
                  ),
                  const Text(
                    "Reviewed: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'LibreFranklin',
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Container(
                    width: 60,
                  ),
                  Column(
                    // Align icons vertically using Column
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${CardTotals.correct + CardTotals.incorrect}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'LibreFranklin',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      )
                    ],
                  ),
                ]),
                Row(children: [
                  Container(
                    width: 30,
                  ),
                  const Text(
                    "Correct: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'LibreFranklin',
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Container(
                    width: 60,
                  ),
                  Column(
                    // Align icons vertically using Column
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${((100 * CardTotals.correct / (CardTotals.correct + CardTotals.incorrect))).toStringAsFixed(2)} %",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'LibreFranklin',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      )
                    ],
                  ),
                ]),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void setIndex(int num) {
    setState(() {
      indexPos = num;
    });
  }
}

class MyIconWidget extends StatefulWidget {
  final Function increment;

  MyIconWidget({required this.increment, super.key});

  @override
  _MyIconWidgetState createState() => _MyIconWidgetState();
}

class _MyIconWidgetState extends State<MyIconWidget> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildButton(Ri.pie_chart_2_fill, 0),
        SizedBox(width: 10),
        buildButton(Ri.bar_chart_2_fill, 1),
      ],
    );
  }

  Widget buildButton(String icon, int index) {
    Color buttonColor = index == activeIndex
        ? Colors.white.withAlpha(160)
        : Colors.white.withAlpha(60);

    return InkWell(
      onTap: () {
        setState(() {
          widget.increment(index);
          activeIndex = index;
          print(index);
        });
      },
      child: Iconify(
        icon,
        color: buttonColor,
        size: 30,
      ),
    );
  }
}
