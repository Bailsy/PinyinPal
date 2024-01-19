// Dart Imports
import 'dart:ffi';
import 'dart:ui';

// Local Imports
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// PinyinPal Imports
import 'package:pinyinpal/databasecontrol.dart';
import 'package:pinyinpal/finishedset.dart';
import 'package:pinyinpal/home.dart';
import 'package:pinyinpal/login.dart';
import 'package:pinyinpal/popups.dart';
import 'package:pinyinpal/config.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await AppConfig.setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key});

  @override
  State<LandingPage> createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  final TextEditingController pinyinController = TextEditingController();

  @override
  void dispose() {
    pinyinController.dispose();
    super.dispose();
  }

  int count = 0;
  int max = 0;
  double height = 0;
  int correct = 5;
  int incorrect = 4;
  String hanzi = "nothing";
  int maxcount = 1;

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    Future<int> futureMax = DataBaseIntegration.getDBsize();
    futureMax.then((intResult) {
      max = intResult;
    });
    var physicalScreenSize = window.physicalSize;
    height = physicalScreenSize.height / 2;
    print(height);
  }

  void _incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 26),
              ),
            ),
            Container(
              child: buildFutureBuilder(),
            ),
            Container(
              padding: EdgeInsets.only(top: height / 3, left: 40, right: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: TextFormField(
                  controller: pinyinController,
                  onFieldSubmitted: (value) {
                    //when the enter button is pressed on the keyboard this is the text which will be printed
                    if(count == maxcount){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinishedSet(Tcorrect: correct, Tincorrect: incorrect,)));
                    }
                    if (pinyinController.text == hanzi  && count !=maxcount) {
                      correct++;
                      AnswerDialog.successPopup(context, hanzi);

                    }
                    if(pinyinController.text != hanzi && count != maxcount){
                      incorrect++;
                      AnswerDialog.failurePopup(context, hanzi);
                    }
                    _incrementCounter();
                    pinyinController.clear();
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontFamily: 'LibreFranklin'),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFutureBuilder() {
    return FutureBuilder(
      future: DataBaseIntegration.connectToDB(count),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> normalList = snapshot.data as List<String>;

          hanzi = normalList[0];

          return Container(
            padding: EdgeInsets.only(top: height / 5, left: 60, right: 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth:  300.0,
                        maxWidth: 300.0,
                        minHeight: 30.0,
                        maxHeight: 100.0,
                      ),
                      child: AutoSizeText(
                        normalList[2],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.0, fontFamily: 'LibreFranklin',color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  Text(
                    (count).toString(),
                    style: TextStyle(
                      color:  Color.fromARGB(255, 255, 255, 255),
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
