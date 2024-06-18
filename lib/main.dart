import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabmate/pages/vocabulary_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'pages/flashcard_page.dart';
import 'pages/home_page.dart';
import 'widgets/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: VocabMateApp())); // Wrap with ProviderScope
}

class VocabMateApp extends StatelessWidget {
  const VocabMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return MaterialApp(
      title: 'VocabMate',
      theme: vocabMateTheme,
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
        '/flashcard-page': (context) => const FlashCardPage(),
        '/vocabulary-page': (context) => const VocabularyPage(),
      },
    );
  }
}
