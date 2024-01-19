import 'dart:io';
import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import 'package:pinyinpal/main.dart';
import 'package:pinyinpal/page/flashcard.dart';

class HomePage extends StatefulWidget {
  // It is essential to give the class a key and make it constant
  const HomePage({Key? key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
                 decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 26),
              ),
            
            ),
        Align(
          alignment: Alignment.center,
          child: InkWell(

          child: Neon(
              text: 'PinYin Pal',
              color: Colors.blue,
              fontSize: 40,
              font: NeonFont.Beon,
              flickeringText: true,
              flickeringLetters: null,
              glowingDuration: new Duration(seconds: 1),  
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FlashCardTimed()));
              
            },
          ),
            ),
          ],
        ),
      ),
    );
  }
}
