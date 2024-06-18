class FlashCard {
  final int index;
  final String question;
  final String answer;
  final String vocabularyLanguage;
  final String explanationLanguage;
  final String vocabWord;
  final String vocabMeaning;

  FlashCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.vocabularyLanguage,
    required this.explanationLanguage,
    required this.vocabWord,
    required this.vocabMeaning,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      index: json['index'],
      question: json['question'],
      answer: json['answer'],
      vocabularyLanguage: json['vocabulary_language'],
      explanationLanguage: json['explanation_language'],
      vocabWord: json['vocab_word'],
      vocabMeaning: json['vocab_meaning'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'question': question,
      'answer': answer,
      'vocabulary_language': vocabularyLanguage,
      'explanation_language': explanationLanguage,
      'vocab_word': vocabWord,
      'vocab_meaning': vocabMeaning,
    };
  }
}
