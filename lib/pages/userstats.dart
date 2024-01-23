import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/pages/home.dart';
import 'package:pinyinpal/setprofile.dart';

class UserStats extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const UserStats({Key? key});

  @override
  UserStatsState createState() => UserStatsState();
}

class UserStatsState extends State<UserStats> {
  ProfileModel currentProfile = ProfileModelSingleton().profileModel;
  //SetProfile sp = SetProfile();
  @override
  void initState() {
    super.initState();
    //sp.reloadDetails();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                "USER STATISTICS\n用户统计 ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'LibreFranklin',
                    color: Colors.grey),
              ),
            ))),
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
                    color: Colors.grey),
              ),
            ))),
      ],
    )));
  }
}
