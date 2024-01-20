abstract class GameMode {
  Future<void> initialize();
  void startGame();
  Future<void> handleAnswer(String userAnswer);
  int getScore();
}
