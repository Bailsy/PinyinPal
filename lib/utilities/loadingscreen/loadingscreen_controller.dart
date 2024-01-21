import 'package:pinyinpal/page/modes/flashcardrace/flashcardtimedmodel.dart';

class LoadingScreenController {
  static Map<String, Function> gameModes = {
    'mode1': () => FlashCardTimedModel().initializeDataFromDatabase(),
    // Add more game modes as needed
  };
}
