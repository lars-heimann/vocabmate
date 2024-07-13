import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> syncUser(String userId, String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/sync-user'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'userId': userId, 'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sync user');
    }
  }

  Future<void> updateUserToPremium(String userId) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/update-to-premium'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user to premium');
    }
  }

  Future<bool> checkPremiumStatus(String userId) async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/is-premium/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['isPremium'];
    } else {
      throw Exception('Failed to load premium status');
    }
  }
}
