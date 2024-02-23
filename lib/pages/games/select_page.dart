import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/providers/flashcardspoken_provider.dart';
import 'package:pinyinpal/providers/flashcardtimed_provider.dart';
import 'package:iconify_flutter/icons/ph.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              "GAMES",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'LibreFranklin',
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Container(
          height: 100,
        ),
        Center(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            padding: EdgeInsets.all(16.0),
            children: [
              _buildGameElement(Ph.timer, 'Timed'),
              _buildGameElement(Ph.speaker_high, 'Spoken'),
              _buildGameElement(Ph.users_three, 'Multi'),
              // Add more GestureDetector widgets for additional games as needed
            ],
          ),
        )
      ],
    );
  }

  Widget _buildGameElement(String iconName, String gameName) {
    return Container(
      decoration: BoxDecoration(
        color: pLightGreyColour, // Set background color for the element
        borderRadius:
            BorderRadius.circular(8.0), // Set border radius for the element
        border: Border.all(
            color: pLightGreyColour), // Set border color for the element
      ),
      child: GestureDetector(
        onTap: () {
          // Navigate to the corresponding game provider
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => gameName == 'Timed'
                  ? const FlashCardTimedProvider()
                  : const FlashCardSpokenProvider(),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconify(
              iconName,
              color: Colors.blue.withAlpha(160),
              size: 100,
            ), // Set height and width for the image
            SizedBox(height: 8.0),
            Text(
              gameName,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
