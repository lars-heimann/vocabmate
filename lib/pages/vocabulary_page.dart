import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/vocabulary_service.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  bool _showFullCards = true;

  Future<List<FlashCard>> _fetchFlashcards(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return [];
    }
    try {
      return await VocabularyService().fetchFlashcards(userId);
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
                const Text('Show Full Flashcards'),
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
                          : Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vocab Word: ${flashcards[index].vocabWord}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    Text(
                                      'Meaning: ${flashcards[index].vocabMeaning}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            );
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
