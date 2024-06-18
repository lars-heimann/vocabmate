class FlashCard {
  final int index;
  final String question;
  final String answer;
  final String vocabularyLanguage;
  final String explanationLanguage;

  FlashCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.vocabularyLanguage,
    required this.explanationLanguage,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      index: json['index'],
      question: json['question'],
      answer: json['answer'],
      vocabularyLanguage: json['vocabulary_language'],
      explanationLanguage: json['explanation_language'],
    );
  }
}
