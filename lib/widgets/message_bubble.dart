import 'package:flutter/material.dart';
import '../models/message.dart';
import '../utils/app_theme.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isUser)
          Container(
            width: 32, height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('N', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700)),
            ),
          ),
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.accent : AppTheme.surfaceAlt,
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomRight: isUser ? const Radius.circular(4) : null,
                bottomLeft: !isUser ? const Radius.circular(4) : null,
              ),
              border: isUser ? null : Border.all(color: AppTheme.border, width: 0.5),
            ),
            child: Text(
              message.content,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.white,
                fontSize: 15, height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
