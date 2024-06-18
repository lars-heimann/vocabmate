import 'package:csv/csv.dart';
import '../models/flashcard_model.dart';

String generateCsv(List<FlashCard> flashCards) {
  List<List<String>> rows = [
    [
      'Index',
      'Question',
      'Answer',
      'Vocabulary Language',
      'Explanation Language'
    ]
  ];

  for (var flashCard in flashCards) {
    rows.add([
      flashCard.index.toString(),
      flashCard.question,
      flashCard.answer,
      flashCard.vocabularyLanguage,
      flashCard.explanationLanguage,
    ]);
  }

  return const ListToCsvConverter().convert(rows);
}
