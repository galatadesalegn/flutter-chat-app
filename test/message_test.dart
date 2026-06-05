import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_ai_chat/models/message.dart';

void main() {
  group('Message', () {
    test('creates message with correct fields', () {
      final msg = Message(
        id: '123',
        role: MessageRole.user,
        content: 'Hello',
        timestamp: DateTime(2026, 1, 1),
      );
      expect(msg.id, '123');
      expect(msg.role, MessageRole.user);
      expect(msg.content, 'Hello');
    });

    test('toJson returns correct map', () {
      final msg = Message(
        id: 'abc',
        role: MessageRole.assistant,
        content: 'Hi there',
        timestamp: DateTime(2026, 6, 1),
      );
      final json = msg.toJson();
      expect(json['id'], 'abc');
      expect(json['role'], 'assistant');
      expect(json['content'], 'Hi there');
    });

    test('fromJson reconstructs message', () {
      final json = {
        'id': 'xyz',
        'role': 'user',
        'content': 'Test',
        'timestamp': '2026-01-01T00:00:00.000',
      };
      final msg = Message.fromJson(json);
      expect(msg.id, 'xyz');
      expect(msg.role, MessageRole.user);
      expect(msg.content, 'Test');
    });
  });

  group('Conversation', () {
    test('creates conversation with empty messages by default', () {
      final conv = Conversation(
        id: '1',
        title: 'Test',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      expect(conv.messages, isEmpty);
    });

    test('copyWith updates title', () {
      final conv = Conversation(
        id: '1', title: 'Old',
        createdAt: DateTime.now(), updatedAt: DateTime.now(),
      );
      final updated = conv.copyWith(title: 'New');
      expect(updated.title, 'New');
      expect(updated.id, '1');
    });
  });
}
