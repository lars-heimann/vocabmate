import 'dart:convert';
import 'package:http/http.dart' as http;

class VocabularyService {
  Future<List<String>> fetchVocabulary(String userId) async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/known-words/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((word) => word.toString()).toList();
    } else {
      throw Exception('Failed to load known words');
    }
  }
}
