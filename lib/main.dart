import 'package:flutter/material.dart';
import 'chatgpt_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VocabMateApp());
}

class VocabMateApp extends StatelessWidget {
  const VocabMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return MaterialApp(
      title: 'VocabMate',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home-page',
      routes: {
        '/sign-in': (context) => SignInScreen(
              providers: providers,
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushReplacementNamed(context, '/home-page');
                }),
              ],
            ),
        '/home-page': (context) => const VocabMateHomePage(),
      },
    );
  }
}

class VocabMateHomePage extends StatefulWidget {
  const VocabMateHomePage({super.key});

  @override
  _VocabMateHomePageState createState() => _VocabMateHomePageState();
}

class _VocabMateHomePageState extends State<VocabMateHomePage> {
  final TextEditingController _controller = TextEditingController();
  final ChatGptService _chatGptService = ChatGptService();
  String _response = '';
  bool _isLoading = false;

  void _sendMessage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _chatGptService.sendMessage(_controller.text);
      setState(() {
        _response = response;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
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
              child: const Text('Send'),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    _response,
                    style: const TextStyle(fontSize: 16.0),
                  ),
          ],
        ),
      ),
    );
  }
}
