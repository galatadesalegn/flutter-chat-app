import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final chat = context.watch<ChatProvider>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _sectionHeader('APPEARANCE'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
            activeColor: cs.primary,
          ),
          const Divider(),
          _sectionHeader('DATA'),
          ListTile(
            title: Text('Conversations (${chat.conversations.length})'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title: const Text('Clear All Chats', style: TextStyle(color: Colors.red)),
            trailing: const Icon(Icons.delete_outline, color: Colors.red),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Clear all chats?'),
                content: const Text('This will permanently delete all conversations.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  TextButton(
                    onPressed: () { chat.clearAll(); Navigator.pop(context); },
                    child: const Text('Clear', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          _sectionHeader('ABOUT'),
          const ListTile(title: Text('Version'), trailing: Text('1.0.0')),
          const ListTile(title: Text('Model'), trailing: Text('claude-3-haiku')),
          const ListTile(title: Text('Framework'), trailing: Text('Flutter 3.x')),
        ],
      ),
    );
  }

  Widget _sectionHeader(String label) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: Colors.grey)),
      );
}
