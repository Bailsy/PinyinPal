import 'package:flutter/material.dart';
import 'package:pinyinpal/databasecontrol.dart';
import 'package:pinyinpal/home.dart';
import 'package:pinyinpal/popups.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  String hanzi = "nothing";

  @override
  void initState() {
    super.initState();
    //perform initialisation tasks here
    Future<int> futureMax = DataBaseIntegration.getDBsize();
    futureMax.then((intResult) {max = intResult;});

  }

  void _incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(max);
    print(MediaQuery.of(context).size.height/20);
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
              
              
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2,left: 40, right: 40),
              child: Align(  
              alignment: Alignment.topCenter,

              child: TextFormField(
                controller: pinyinController,
                onFieldSubmitted: (value) {

                  if(pinyinController.text == hanzi){
                    AnswerDialog.successPopup(context, hanzi);
                  }
                  else{
                    AnswerDialog.failurePopup(context, hanzi);
                  }
                  print(hanzi);

                  _incrementCounter();
                  
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20, fontFamily: 'LibreFranklin'),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  filled: true,
                ),
               ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,

            )
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5, left: 60, right: 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Text(
                    normalList[2],
                    style: TextStyle(
                      fontFamily: 'LibreFranklin',
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 45,
                    ),
                  ),

                  Text(
                    "Size: " + (max - count).toString(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
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
