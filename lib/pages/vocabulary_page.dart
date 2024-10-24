import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/vocabulary_service.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/vocabulary_widget.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  bool _showFullCards = true;

  Future<List<FlashCard>> _fetchFlashcards(BuildContext context) async {
    final firebase_uid = FirebaseAuth.instance.currentUser?.uid;
    if (firebase_uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return [];
    }
    try {
      return await VocabularyService().fetchFlashcards(firebase_uid);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Show Full Flashcards',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Switch(
                  value: _showFullCards,
                  onChanged: (value) {
                    setState(() {
                      _showFullCards = value;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<FlashCard>>(
                future: _fetchFlashcards(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final flashcards = snapshot.data ?? [];
                  if (flashcards.isEmpty) {
                    return const Center(child: Text('No flashcards found.'));
                  }
                  return ListView.builder(
                    itemCount: flashcards.length,
                    itemBuilder: (context, index) {
                      return _showFullCards
                          ? FlashCardWidget(card: flashcards[index])
                          : VocabularyWidget(card: flashcards[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
