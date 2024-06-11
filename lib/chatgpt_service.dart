import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ChatGptService {
  final String apiKey;
  final String model;

  ChatGptService({required this.apiKey, this.model = 'gpt-3.5-turbo'});

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': model,
        'messages': [
          {'role': 'user', 'content': message}
        ],
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Failed to load response');
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
}
