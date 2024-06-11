enum CardGenerationSize {
  five,
  ten,
  twenty,
  thirty,
  fifty,
  seventyFive,
  hundred,
  hundertFifty;

  int toInt() {
    switch (this) {
      case CardGenerationSize.five:
        return 5;
      case CardGenerationSize.ten:
        return 10;
      case CardGenerationSize.twenty:
        return 20;
      case CardGenerationSize.thirty:
        return 30;
      case CardGenerationSize.fifty:
        return 50;
      case CardGenerationSize.seventyFive:
        return 75;
      case CardGenerationSize.hundred:
        return 100;
      case CardGenerationSize.hundertFifty:
        return 150;
    }
  }

  String getUiText() {
    return '${toInt()}';
  }

  bool isPlus() {
    switch (this) {
      case CardGenerationSize.thirty:
      case CardGenerationSize.fifty:
      case CardGenerationSize.seventyFive:
      case CardGenerationSize.hundred:
      case CardGenerationSize.hundertFifty:
        return true;
      default:
        return false;
    }
  }

  bool isAvailableForFiles() {
    switch (this) {
      case CardGenerationSize.twenty:
      case CardGenerationSize.thirty:
      case CardGenerationSize.fifty:
      case CardGenerationSize.seventyFive:
      case CardGenerationSize.hundred:
      case CardGenerationSize.hundertFifty:
        return true;
      default:
        return false;
    }
  }
}
