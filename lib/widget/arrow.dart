import 'package:flutter/material.dart';

class Arrow extends StatelessWidget {
  final Color arrowColor;
  Arrow({required this.arrowColor, Key? key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      height: 5, // Adjust height as needed
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VerticalDivider(
            color: arrowColor,
            thickness: 2.0,
          ),
          Container(
            height: 12.0, // Adjust arrow height as needed
            child: Icon(
              Icons.arrow_downward,
              size: 20.0, // Adjust arrow size as needed
              color: arrowColor,
            ),
          ),
        ],
      ),
    );
  }
}
