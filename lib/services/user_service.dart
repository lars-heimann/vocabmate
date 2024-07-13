import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> syncUser(String firebaseUid, String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/sync-user'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'firebase_uid': firebaseUid, 'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sync user');
    }
  }

  Future<void> upgradeToPremium(String firebaseUid) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/upgrade-to-premium'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'firebase_uid': firebaseUid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to upgrade user to premium');
    }
  }

  Future<void> downgradeToFree(String firebaseUid) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/downgrade-to-free'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'firebase_uid': firebaseUid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to downgrade user to free');
    }
  }

  Future<bool> isPremium(String firebaseUid) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/is-premium/$firebaseUid'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse['isPremium'];
    } else {
      throw Exception('Failed to load premium status');
    }
  }
}
