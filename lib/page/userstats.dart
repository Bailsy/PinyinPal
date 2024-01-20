import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/model/databasecontrol.dart';
import 'package:pinyinpal/page/home.dart';

class UserStats extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const UserStats({Key? key});

  @override
  UserStatsState createState() => UserStatsState();
}

class UserStatsState extends State<UserStats> {
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
            Container(
              child: FutureBuilder(
                future: DataBaseIntegration.getUserStats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("");
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<ResultRow> normalList =
                        snapshot.data as List<ResultRow>;

                    return Container(
                        child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Name: " + "${normalList[0]['UNAME'].toString()}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Rank Level: " +
                                "${normalList[0]['USERTYPE'].toString()}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "XP Level: " + "${normalList[0]['XP'].toString()}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ));
                  }
                },
              ),
            )
          ],
        )));
  }
}
