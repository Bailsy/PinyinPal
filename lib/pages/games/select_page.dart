import 'package:flutter/material.dart';
import 'package:pinyinpal/providers/flashcardspoken_provider.dart';
import 'package:pinyinpal/providers/flashcardtimed_provider.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        padding: EdgeInsets.all(16.0),
        children: [
          _buildGameElement(
              'assets/images/gamemode_icons/flashcardtimed_icon.png',
              'FlashCard Timed'),
          _buildGameElement('assets/images/hsk1Button.png', 'FlashCard Spoken'),
          // Add more GestureDetector widgets for additional games as needed
        ],
      ),
    );
  }

  Widget _buildGameElement(String imagePath, String gameName) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set background color for the element
        borderRadius:
            BorderRadius.circular(8.0), // Set border radius for the element
        border:
            Border.all(color: Colors.black), // Set border color for the element
      ),
      child: GestureDetector(
        onTap: () {
          // Navigate to the corresponding game provider
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => gameName == 'FlashCard Timed'
                  ? const FlashCardTimedProvider()
                  : const FlashCardSpokenProvider(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath,
                height: 80.0,
                width: 80.0), // Set height and width for the image
            SizedBox(height: 8.0),
            Text(
              gameName,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
