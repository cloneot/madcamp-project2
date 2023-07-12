import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatDataProvider extends ChangeNotifier {
  final List<ChatMessage> _chatMessages = [];

  List<ChatMessage> get chatMessages => _chatMessages;

  void addChatMessage(ChatMessage chat) {
    print(
        'addChatMessage: ${chat.message} ${chat.messageScore} ${chat.sendingPlayer}');
    _chatMessages.add(chat);
    notifyListeners();
  }

  void clearChatMessage() {
    _chatMessages.clear();
  }
}
