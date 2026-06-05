import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/conversation_tile.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Nexus', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700)),
            Text('AI Assistant', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: provider.conversations.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🤖', style: TextStyle(fontSize: 56)),
                  SizedBox(height: 16),
                  Text('Start a conversation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Tap the button below to chat with Nexus',
                      style: TextStyle(color: AppTheme.textSecondary)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: provider.conversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final conv = provider.conversations[i];
                return ConversationTile(
                  conversation: conv,
                  onTap: () {
                    provider.selectConversation(conv.id);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          provider.createConversation();
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
        },
        backgroundColor: AppTheme.accent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
