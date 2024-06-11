import 'dart:convert';
import 'package:http/http.dart' as http;

class FlashcardService {
  Future<void> addFlashcards(
      String userId, List<Map<String, dynamic>> flashcards) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/add-flashcards'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'flashcards': flashcards,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add flashcards: ${response.body}');
    }
  }
}
