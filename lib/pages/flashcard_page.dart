import 'package:flutter/material.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';

class FlashCardPage extends StatelessWidget {
  const FlashCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FlashCard> flashCards =
        ModalRoute.of(context)!.settings.arguments as List<FlashCard>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashCards'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: flashCards.length,
          itemBuilder: (context, index) {
            return FlashCardWidget(card: flashCards[index]);
          },
        ),
      ),
    );
  }
}
