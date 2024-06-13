class FlashCard {
  final int index;
  final String question;
  final String answer;
  final String questionLanguage;
  final String answerLanguage;

  FlashCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.questionLanguage,
    required this.answerLanguage,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      index: json['index'],
      question: json['question'],
      answer: json['answer'],
      questionLanguage: json['question_language'],
      answerLanguage: json['answer_language'],
    );
  }
}
