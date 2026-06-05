import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ChatInput extends StatefulWidget {
  final void Function(String) onSend;
  final bool disabled;
  const ChatInput({super.key, required this.onSend, this.disabled = false});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.disabled) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !widget.disabled,
              maxLines: null,
              maxLength: 4000,
              buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
              decoration: const InputDecoration(hintText: 'Message Nexus...', contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _handleSend,
            child: Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: widget.disabled ? AppTheme.border : AppTheme.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
