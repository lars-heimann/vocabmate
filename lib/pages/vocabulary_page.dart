import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/vocabulary_service.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  Future<List<String>> _fetchKnownWords(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return [];
    }
    try {
      return await VocabularyService().fetchVocabulary(userId);
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
        title: const Text('Known Words'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: _fetchKnownWords(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final knownWords = snapshot.data ?? [];
            if (knownWords.isEmpty) {
              return const Center(child: Text('No known words found.'));
            }
            return ListView.builder(
              itemCount: knownWords.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      knownWords[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
