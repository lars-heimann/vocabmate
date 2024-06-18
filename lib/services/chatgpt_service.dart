import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ChatGptService {
  Future<String> sendMessage(String userId, String message) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/generate-anki-cards-with-known-words'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'userId': userId, 'text': message}),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response into a readable format
      final jsonResponse = jsonDecode(response.body);
      return jsonEncode(jsonResponse); // or format as desired
    } else {
      throw Exception('Failed to load response: ${response.body}');
    }
  }

  Future<String> sendDummyMessage(String message) async {
    List<String> dummyMessages = [
      "Message received successfully.",
      "Your request has been processed.",
      "Action completed without errors.",
      "Thank you for your message.",
      "Your message has been recorded.",
      "Operation completed successfully.",
      "The process is complete.",
      "We have received your submission.",
      "Your entry has been logged.",
      "Task executed perfectly."
    ];

    // Generate a random index to select a message from the list
    int index = Random().nextInt(dummyMessages.length);

    // Return the randomly selected message
    return dummyMessages[index];
  }

  Future<String> generateTestFlashcards() async {
    // Return a dummy JSON response
    final List<Map<String, dynamic>> dummyFlashcards = [
      {
        "index": 1,
        "question":
            "What is the meaning of 'Milch' in the context of 'Ich trinke Milch'?",
        "answer": "The meaning/translation of 'Milch' is milk.",
        "vocabulary_language": "German",
        "explanation_language": "English",
        "vocab_word": "Milch",
        "vocab_meaning": "milk"
      },
      {
        "index": 2,
        "question":
            "What is the meaning of 'Hund' in the context of 'Der Hund bellt'?",
        "answer": "The meaning/translation of 'Hund' is dog.",
        "vocabulary_language": "German",
        "explanation_language": "English",
        "vocab_word": "Hund",
        "vocab_meaning": "dog"
      },
      // Add more dummy flashcards as needed
    ];

    return jsonEncode(dummyFlashcards);
  }
}
