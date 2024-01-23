import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pinyinpal/constants/colour.dart';

class BottomNavBar extends StatefulWidget {
  static int indexPos = 0;
  final Function(int) onIndexChanged;
  BottomNavBar({required this.onIndexChanged});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.lightBlue.withOpacity(0.4),
          tabBackgroundColor: pGreyColour,
          padding: EdgeInsets.all(8),
          onTabChange: (index) {
            widget.onIndexChanged(index);
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: " Lessons",
            ),
            GButton(
              icon: Icons.card_membership,
              text: " Flashcards",
            ),
            GButton(
              icon: Icons.school,
              text: " Collection",
            ),
            GButton(
              icon: Icons.bar_chart,
              text: " Stats",
            ),
          ],
        ),
      ),
    );
  }
}
