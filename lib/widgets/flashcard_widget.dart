import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCard card;

  const FlashCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q: ${card.question}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('A: ${card.answer}'),
            const SizedBox(height: 8.0),
            Text('Question Language: ${card.questionLanguage}'),
            Text('Answer Language: ${card.answerLanguage}'),
          ],
        ),
      ),
    );
  }
}
