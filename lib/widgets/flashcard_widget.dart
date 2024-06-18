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
              '${card.vocabWord} — ${card.vocabMeaning}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Question: ${card.question}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    card.vocabularyLanguage,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Answer: ${card.answer}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    card.explanationLanguage,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
