import 'package:flutter/material.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the children vertically
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
                  "USER STATISTICS\n用户统计 ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'LibreFranklin',
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: const Divider(color: Colors.grey),
          ),
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
                child: Text(
                  currentProfile.experience.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'LibreFranklin',
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
          ),
          Container(
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
