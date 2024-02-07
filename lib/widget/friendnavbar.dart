import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pinyinpal/constants/colour.dart';

class FriendsNavBar extends StatefulWidget {
  static int indexPos = 0;
  final Function(int) onIndexChanged;
  const FriendsNavBar({super.key, required this.onIndexChanged});
  @override
  FriendsNavBarState createState() => FriendsNavBarState();
}

class FriendsNavBarState extends State<FriendsNavBar> {
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
          padding: const EdgeInsets.all(8),
          onTabChange: (index) {
            widget.onIndexChanged(index);
          },
          tabs: const [
            GButton(
              icon: Icons.search,
              text: "Finder",
            ),
            GButton(
              icon: Icons.mail_rounded,
              text: "Requests",
            ),
            GButton(
              icon: Icons.circle,
              text: "Circle",
            ),
          ],
        ),
      ),
    );
  }
}
