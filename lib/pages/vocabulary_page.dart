import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/vocabulary_service.dart';
import '../models/flashcard_model.dart';
import '../widgets/flashcard_widget.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

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
                return FlashCardWidget(card: flashcards[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
