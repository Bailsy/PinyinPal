import 'package:pinyinpal/pages/modes/flashcardrace/flashcardtimedmodel.dart';

class LoadingScreenController {
  static Map<String, Function> gameModes = {
    'mode1': () => FlashCardTimedModel().initializeDataFromDatabase(),
    // Add more game modes as needed
  };
}
