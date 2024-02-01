import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pinyinpal/pages/modes/flashcardrace/flashcardtimed.dart';
import 'package:pinyinpal/models/flashcardtimedmodel.dart';

class FlashCardTimedProvider extends StatelessWidget {
  const FlashCardTimedProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FlashCardTimedModel(),
      child: FlashCardTimed(),
    );
  }
}
