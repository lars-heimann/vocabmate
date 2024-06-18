import 'package:flutter/material.dart';
import 'package:vocabmate/pages/home_page/about_section.dart';
import '../services/chatgpt_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import '../models/flashcard_model.dart';
import 'dart:convert';

class VocabMateHomePage extends StatefulWidget {
  const VocabMateHomePage({super.key});

  @override
  _VocabMateHomePageState createState() => _VocabMateHomePageState();
}

class _VocabMateHomePageState extends State<VocabMateHomePage> {
  final TextEditingController _controller = TextEditingController();
  final ChatGptService _chatGptService = ChatGptService();
  bool _isLoading = false;

  void _sendMessage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _chatGptService.sendMessage(_controller.text);
      final List<dynamic> jsonResponse = jsonDecode(response);
      final List<FlashCard> flashCards =
          jsonResponse.map((data) => FlashCard.fromJson(data)).toList();

      Navigator.pushNamed(
        context,
        '/flashcard-page',
        arguments: {'inputText': _controller.text, 'flashCards': flashCards},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/sign-in'); // Direct navigation
  }

  void _navigateToVocabulary() {
    Navigator.pushNamed(context, '/vocabulary-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabmate'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: _navigateToVocabulary,
            tooltip: 'Known Words',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(labelText: 'Enter your message'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendMessage,
              child: const Text('Generate Flashcards'),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const CircularProgressIndicator()
                : const Text('Enter a message to generate flashcards'),
            const AboutSection()
          ],
        ),
      ),
    );
  }
}
