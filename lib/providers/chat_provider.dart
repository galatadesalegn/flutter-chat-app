import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/ai_service.dart';

class ChatProvider extends ChangeNotifier {
  final AiService _aiService;

  List<Conversation> _conversations = [];
  String? _activeId;
  bool _isLoading = false;
  String? _error;

  ChatProvider({required AiService aiService}) : _aiService = aiService;

  List<Conversation> get conversations => _conversations;
  String? get activeId => _activeId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Conversation? get activeConversation =>
      _conversations.where((c) => c.id == _activeId).isNotEmpty
          ? _conversations.firstWhere((c) => c.id == _activeId)
          : null;

  String _generateId() =>
      DateTime.now().millisecondsSinceEpoch.toString() +
      (1000 + (999 * (DateTime.now().microsecond / 1000000)).round()).toString();

  Conversation createConversation() {
    final conv = Conversation(
      id: _generateId(),
      title: 'New Chat',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _conversations = [conv, ..._conversations];
    _activeId = conv.id;
    notifyListeners();
    return conv;
  }

  void selectConversation(String id) {
    _activeId = id;
    notifyListeners();
  }

  void deleteConversation(String id) {
    _conversations = _conversations.where((c) => c.id != id).toList();
    if (_activeId == id) _activeId = null;
    notifyListeners();
  }

  void clearAll() {
    _conversations = [];
    _activeId = null;
    notifyListeners();
  }

  Future<void> sendMessage(String content) async {
    if (_activeId == null) return;

    final userMsg = Message(
      id: _generateId(),
      role: MessageRole.user,
      content: content,
      timestamp: DateTime.now(),
    );

    _addMessage(userMsg);
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final history = [...activeConversation!.messages];
      final reply = await _aiService.sendMessage(history);

      final aiMsg = Message(
        id: _generateId(),
        role: MessageRole.assistant,
        content: reply,
        timestamp: DateTime.now(),
      );
      _addMessage(aiMsg);
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _addMessage(Message msg) {
    final conv = activeConversation!;
    final updated = Conversation(
      id: conv.id,
      title: conv.messages.isEmpty ? msg.content.substring(0, msg.content.length.clamp(0, 40)) : conv.title,
      messages: [...conv.messages, msg],
      createdAt: conv.createdAt,
      updatedAt: DateTime.now(),
    );
    _conversations = _conversations.map((c) => c.id == conv.id ? updated : c).toList();
  }
}
