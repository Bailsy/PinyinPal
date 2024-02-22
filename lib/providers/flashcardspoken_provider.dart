import 'package:flutter/material.dart';
import 'package:pinyinpal/pages/modes/flashcard/flashcardspoken.dart';
import 'package:provider/provider.dart';
import 'package:pinyinpal/models/flashcardtimedmodel.dart';

class FlashCardSpokenProvider extends StatelessWidget {
  const FlashCardSpokenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlashCardTimedModel(),
      child: const FlashCardSpoken(),
    );
  }
}
