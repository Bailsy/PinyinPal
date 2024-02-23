import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/widget/piechart.dart';

class UserStats extends StatefulWidget {
  const UserStats({super.key});

  @override
  UserStatsState createState() => UserStatsState();
}

class UserStatsState extends State<UserStats> {
  ProfileModel currentProfile = ProfileModelSingleton().profileModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                "STATS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'LibreFranklin',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: GlassmorphicContainer(
              height: 250,
              width: 250,
              borderRadius: 7,
              border: 0.9,
              blur: 7,
              alignment: Alignment.center,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 193, 193, 193).withAlpha(20),
                  Color(0xFFffffff).withAlpha(45),
                ],
                stops: [0.3, 1],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color(0xFF4579C5).withAlpha(10),
                  Color(0xFFFFFFF).withAlpha(55),
                  Color.fromARGB(255, 65, 39, 179).withAlpha(10),
                ],
                stops: [0.06, 0.6, 1],
              ),
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
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
          ),
          GlassmorphicContainer(
            height: 250,
            width: 250,
            borderRadius: 7,
            border: 0.6,
            blur: 7,
            alignment: Alignment.center,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 193, 193, 193).withAlpha(20),
                  Color(0xFFffffff).withAlpha(45),
                ],
                stops: [
                  0.3,
                  1,
                ]),
            borderGradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color(0xFF4579C5).withAlpha(100),
                  Color(0xFFFFFFF).withAlpha(55),
                  Color.fromARGB(255, 65, 39, 179).withAlpha(10),
                ],
                stops: [
                  0.06,
                  0.95,
                  1
                ]),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 100.0,
                maxWidth: 200.0,
                minHeight: 100.0,
                maxHeight: 200.0,
              ),
              child: StatsChart(),
            ),
          ),
        ],
      ),
    );
  }
}
