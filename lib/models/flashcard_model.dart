class FlashCard {
  final int index;
  final String question;
  final String answer;
  final String vocabulary_language;
  final String explanation_language;

  FlashCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.vocabulary_language,
    required this.explanation_language,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      index: json['index'],
      question: json['question'],
      answer: json['answer'],
      vocabulary_language: json['vocabulary_language'],
      explanation_language: json['explanation_language'],
    );
  }
}
