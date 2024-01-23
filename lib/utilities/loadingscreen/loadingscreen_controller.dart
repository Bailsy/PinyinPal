import 'package:pinyinpal/models/flashcardtimedmodel.dart';

class LoadingScreenController {
  static Map<String, Function> gameModes = {
    'mode1': () => FlashCardTimedModel().initializeDataFromDatabase(),
    // Add more game modes as needed
  };
}
