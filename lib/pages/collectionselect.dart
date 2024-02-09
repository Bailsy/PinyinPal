import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pinyinpal/constants/imagepaths.dart';
import 'package:pinyinpal/models/lvl.dart';
import 'package:pinyinpal/models/profilemodel.dart';
import 'package:pinyinpal/pages/collection/collection_page.dart';
import 'package:pinyinpal/pages/profile.dart';

class CollectionSelectPage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  final VoidCallback reloadPage;
  const CollectionSelectPage({required this.reloadPage, super.key});

  @override
  CollectionSelectPageState createState() => CollectionSelectPageState();
}

class CollectionSelectPageState extends State<CollectionSelectPage> {
  ProfileModel currentProfile = ProfileModelSingleton().profileModel;
  //SetProfile sp = SetProfile();
  @override
  void initState() {
    super.initState();
    //sp.reloadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
                    "MY COLLECTIONS",
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
              height: 20,
            ),
            InkWell(
              onTap: () async {
                HskPath.hsklvl = 'hsk1';
                await HskPath.loadData();
                widget.reloadPage();
              },
              child: Container(
                height: 90,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        hsk1Button), // assuming hsk2Button is the asset path
                    fit: BoxFit.cover, // or any other fit you desire
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                HskPath.hsklvl = 'hsk2';
                await HskPath.loadData();
                widget.reloadPage();
              },
              child: Container(
                height: 90,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        hsk2Button), // assuming hsk2Button is the asset path
                    fit: BoxFit.cover, // or any other fit you desire
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                HskPath.hsklvl = 'hsk2';
                await HskPath.loadData();
                widget.reloadPage();
              },
              child: Container(
                height: 90,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        hsk3Button), // assuming hsk2Button is the asset path
                    fit: BoxFit.cover, // or any other fit you desire
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        )));
  }
}
