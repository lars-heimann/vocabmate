import 'package:flutter/material.dart';
import 'package:vocabmate/pages/home_page/about_section.dart';
import 'package:vocabmate/pages/home_page/app_bar.dart';
import 'package:vocabmate/pages/home_page/faq_section.dart';
import 'package:vocabmate/pages/home_page/input_section.dart';
import 'package:vocabmate/pages/home_page/pricing_section.dart';
import 'package:vocabmate/widgets/footer.dart';
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

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response =
          await _chatGptService.sendMessage(userId, _controller.text);
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

  void _generateTestFlashcards() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _chatGptService.generateTestFlashcards();
      final List<dynamic> jsonResponse = jsonDecode(response);
      final List<FlashCard> flashCards =
          jsonResponse.map((data) => FlashCard.fromJson(data)).toList();

      Navigator.pushNamed(
        context,
        '/flashcard-page',
        arguments: {'inputText': 'Test input text', 'flashCards': flashCards},
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
    return SelectionArea(
      child: Scaffold(
        appBar: const HomePageAppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // Wrapping the widgets around a ConstrainedBox always show the
                // footer at the bottom of the page.
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Column(
                    children: [
                      const InputSection(),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _sendMessage,
                        child: const Text('Generate Flashcards'),
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _generateTestFlashcards,
                        child: const Text('Generate Test Flashcards'),
                      ),
                      // _isLoading
                      //     ? const CircularProgressIndicator()
                      //     : const Text('Enter a message to generate flashcards'),
                      const SizedBox(height: 100),
                      const PricingSection(),
                      const SizedBox(height: 100),
                      const AboutSection(),
                      const SizedBox(height: 100),
                      const FaqSection(),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
