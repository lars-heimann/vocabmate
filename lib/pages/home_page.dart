import 'package:flutter/material.dart';
import 'package:vocabmate/pages/home_page/about_section.dart';
import '../services/chatgpt_service.dart';
import '../services/user_service.dart';
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
  final UserService _userService = UserService();
  bool _isLoading = false;
  bool _isPremium = false;

  @override
  void initState() {
    super.initState();
    _fetchPremiumStatus();
  }

  Future<void> _fetchPremiumStatus() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    try {
      final isPremium = await _userService.checkPremiumStatus(userId);
      setState(() {
        _isPremium = isPremium;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

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

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/sign-in'); // Direct navigation
  }

  void _navigateToVocabulary() {
    Navigator.pushNamed(context, '/vocabulary-page');
  }

  void _upgradeToPremium() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    try {
      await _userService.updateUserToPremium(userId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upgraded to premium successfully')),
      );
      setState(() {
        _isPremium = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
            tooltip: 'Vocabulary',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isPremium)
              const Text(
                'PREMIUM USER',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            else
              const Text(
                'Free User',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            const SizedBox(height: 16.0),
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
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _upgradeToPremium,
              child: const Text('Upgrade to Premium'),
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
