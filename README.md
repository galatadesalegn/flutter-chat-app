<div align="center">

# 🤖 Nexus AI Chat — Flutter

### AI-Powered Chat App built with Flutter & Dart

[![Flutter](https://img.shields.io/badge/Flutter-3.22-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.3-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![CI](https://github.com/galatadesalegn/nexus-ai-chat-flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/galatadesalegn/nexus-ai-chat-flutter/actions)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

> The Flutter version of Nexus AI Chat — same features, different framework. Built with Provider state management and Material 3 design.

</div>

---

## ✨ Features

- 🤖 **Claude AI** — Anthropic claude-3-haiku integration
- 💬 **Multi-conversation** — full conversation management
- 🎨 **Material 3** — modern dark theme with custom colors
- ⌨️ **Animated typing indicator** — smooth 3-dot animation
- 📱 **Cross-platform** — iOS, Android, Web
- 🔄 **Provider state** — clean ChangeNotifier pattern
- 🧪 **Widget & unit tests** — model and widget coverage

---

## 🚀 Getting Started

```bash
git clone https://github.com/galatadesalegn/nexus-ai-chat-flutter.git
cd nexus-ai-chat-flutter
flutter pub get
cp .env.example .env
# Add your Anthropic API key to .env
flutter run
```

---

## 📁 Project Structure

```
nexus-ai-chat-flutter/
├── lib/
│   ├── main.dart              # App entry point
│   ├── models/                # Message, Conversation
│   ├── providers/             # ChatProvider (ChangeNotifier)
│   ├── screens/               # HomeScreen, ChatScreen
│   ├── services/              # AiService (Anthropic API)
│   ├── widgets/               # MessageBubble, ChatInput, TypingIndicator
│   └── utils/                 # AppTheme, helpers
└── test/                      # Flutter unit & widget tests
```

---

## 🛠 Tech Stack

| Layer | Tech |
|-------|------|
| Framework | Flutter 3.22 |
| Language | Dart 3.3 |
| State | Provider + ChangeNotifier |
| AI | Anthropic Claude API |
| HTTP | http package |
| Testing | flutter_test |
| CI | GitHub Actions |

---

## 📄 License
MIT — Built by **Galata Desalegn**
