import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vocabmate/config.dart';
import 'package:vocabmate/models/flashcard_model.dart';

class VocabularyService {
  Future<List<FlashCard>> fetchFlashcards(String userId) async {
    final response =
        await http.get(Uri.parse('${Config.baseUrl}/user-flashcards/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return List<FlashCard>.from(
        jsonResponse['flashcards'].map((data) => FlashCard.fromJson(data)),
      );
    } else {
      throw Exception('Failed to load flashcards');
    }
  }
}
