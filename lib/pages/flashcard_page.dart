import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/input_text_widget.dart';

class FlashCardPage extends StatelessWidget {
  const FlashCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String inputText = arguments['inputText'];
    final List<FlashCard> flashCards = arguments['flashCards'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashCards'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextWidget(inputText: inputText),
            const Divider(height: 32.0),
            Expanded(
              child: ListView.builder(
                itemCount: flashCards.length,
                itemBuilder: (context, index) {
                  return FlashCardWidget(card: flashCards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
