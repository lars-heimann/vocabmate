import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/input_text_widget.dart';
import '../utils/csv_utils.dart';
import 'dart:html' as html; // Import for web clipboard access
import '../services/flashcard_service.dart'; // Import the service
import 'package:firebase_auth/firebase_auth.dart';

class FlashCardPage extends StatelessWidget {
  final String inputText;
  final List<FlashCard> flashCards;
  const FlashCardPage(
      {super.key, required this.inputText, required this.flashCards});

  void _copyCsvToClipboard(BuildContext context, List<FlashCard> flashCards) {
    final csvString = generateCsv(flashCards);

    // Use the web clipboard API to copy the CSV string to the clipboard
    html.window.navigator.clipboard?.writeText(csvString).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'CSV copied to clipboard. Paste it in a CSV file to save.')),
      );
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to copy CSV to clipboard: $err')),
      );
    });
  }

  void _showAnkiExportExplanation(
      BuildContext context, List<FlashCard> flashCards) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Export Instructions'),
          content: const Text('1. Copy the CSV to clipboard\n'
              '2. Create a new text file and paste the CSV content\n'
              '3. Save the file with a .csv extension\n'
              '4. Import the file into Anki using the Anki desktop app (File -> Import)'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveFlashcards(
      BuildContext context, List<FlashCard> flashCards) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final flashcardService = FlashcardService();

    try {
      final flashcardsData = flashCards.map((card) => card.toJson()).toList();
      await flashcardService.addFlashcards(userId, flashcardsData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Flashcards saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving flashcards: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add print statements to debug
    print('Navigated to FlashCardPage with inputText: $inputText');
    print('Navigatted to FlashCardPage with flashCards: $flashCards');

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
            const SizedBox(
                height:
                    8.0), // Add some space between the input text and the button
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy CSV to Clipboard'),
                  onPressed: () => _copyCsvToClipboard(context, flashCards),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 8.0),
                const _ExportButton(),
                const SizedBox(width: 8.0),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Flashcards to Vocabulary'),
                  onPressed: () => _saveFlashcards(context, flashCards),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
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

class _ExportButton extends ConsumerWidget {
  const _ExportButton();

  void _showAnkiExportExplanation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Show Export Instructions'),
          content: const Text('1. Copy the CSV to clipboard\n'
              '2. Create a new text file and paste the CSV content\n'
              '3. Save the file with a .csv extension\n'
              '4. Import the file into Anki using the Anki desktop app (File -> Import)'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.import_export),
      label: const Text('Export instructions'),
      onPressed: () => _showAnkiExportExplanation(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
