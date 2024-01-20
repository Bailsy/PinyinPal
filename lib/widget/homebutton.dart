import 'package:flutter/material.dart';
import 'package:neon/neon.dart';
import 'package:pinyinpal/constants/colour.dart';
import 'package:pinyinpal/constants/deviceinfo.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonText;

  const HomeButton(
      {required this.onPress, required this.buttonText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30, left: 60, right: 60),
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300.0,
              maxWidth: 300.0,
              minHeight: DeviceInfo.physicalHeight / 30,
              maxHeight: DeviceInfo.physicalHeight / 25,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pLightGreyColour,
              ),
              onPressed: onPress,
              child: InkWell(
                child: Neon(
                  text: buttonText,
                  color: Colors.blue,
                  font: NeonFont.Beon,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ));
  }
}
