import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class AiService {
  static const _apiUrl = 'https://api.anthropic.com/v1/messages';
  static const _model = 'claude-3-haiku-20240307';
  static const _maxTokens = 1024;
  static const _systemPrompt =
      'You are Nexus, a helpful, intelligent, and friendly AI assistant '
      'built into a mobile chat app. Give clear, concise, and accurate responses.';

  final String apiKey;

  AiService({required this.apiKey});

  Future<String> sendMessage(List<Message> history) async {
    final messages = history
        .where((m) => m.role != MessageRole.assistant || true)
        .take(20)
        .map((m) => {'role': m.role.name, 'content': m.content})
        .toList();

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: jsonEncode({
        'model': _model,
        'max_tokens': _maxTokens,
        'system': _systemPrompt,
        'messages': messages,
      }),
    );

    if (response.statusCode != 200) {
      final err = jsonDecode(response.body);
      throw Exception(err['error']?['message'] ?? 'API error ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final text = data['content']?[0]?['text'] as String?;
    if (text == null) throw Exception('Empty response from AI.');
    return text;
  }
}
