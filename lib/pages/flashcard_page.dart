import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Clipboard functionality
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/input_text_widget.dart';
import '../utils/csv_utils.dart';
import 'dart:html' as html; // Import for web clipboard access

class FlashCardPage extends StatelessWidget {
  const FlashCardPage({super.key});

  void _copyCsvToClipboard(BuildContext context, List<FlashCard> flashCards) {
    final csvString = generateCsv(flashCards);

    // Use the web clipboard API to copy the CSV string to the clipboard
    html.window.navigator.clipboard?.writeText(csvString).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'CSV copied to clipboard. Paste it in a CSV file to save.')),
      );
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to copy CSV to clipboard: $err')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String inputText = arguments['inputText'];
    final List<FlashCard> flashCards = arguments['flashCards'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashCards'),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () => _copyCsvToClipboard(context, flashCards),
            tooltip: 'Copy CSV to Clipboard',
          ),
        ],
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
