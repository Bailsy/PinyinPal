import 'package:flutter/material.dart';
import 'package:pinyinpal/page/modes/flashcardrace/flashcardtimed.dart';
import 'package:pinyinpal/utilities/Loadingscreen/countdown_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String selectedMode;

  LoadingScreen({required this.selectedMode});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Future<void> loadingFuture;

  @override
  void initState() {
    super.initState();
    // Start loading data during the countdown

    //! NOT WORKING YET
    // loadingFuture = LoadingScreenController.gameModes[widget.selectedMode]!();
    //!
  }

  @override
  Widget build(BuildContext context) {
    return CountdownScreen(
      onCountdownFinished: () {
        // Navigator will wait for loadingFuture to complete

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FlashCardTimed(),
          ),
        );
      },
    );
  }
}
