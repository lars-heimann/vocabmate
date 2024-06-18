import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';

class VocabularyWidget extends StatelessWidget {
  final FlashCard card;

  const VocabularyWidget({super.key, required this.card});

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
          ],
        ),
      ),
    );
  }
}
