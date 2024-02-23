import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pinyinpal/constants/colour.dart';

class BottomNavBar extends StatefulWidget {
  final int startPos;
  final Function(int) onIndexChanged;

  const BottomNavBar(
      {super.key, required this.startPos, required this.onIndexChanged});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: pGreyColour,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          selectedIndex: widget.startPos,
          backgroundColor: pGreyColour,
          color: Colors.white,
          activeColor: Colors.lightBlue.withOpacity(0.4),
          tabBackgroundColor: pGreyColour,
          padding: const EdgeInsets.all(8),
          onTabChange: (index) {
            widget.onIndexChanged(index);
          },
          tabs: const [
            GButton(
              icon: Icons.games,
              text: " Games",
            ),
            GButton(
              icon: Icons.collections_bookmark,
              text: " Collection",
            ),
            GButton(
              icon: Icons.bar_chart,
              text: " Stats",
            ),
            GButton(
              icon: Icons.person,
              text: " Profile",
            ),
          ],
        ),
      ),
    );
  }
  // Function to automatically click on a button 才华
}
