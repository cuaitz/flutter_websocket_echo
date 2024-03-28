import 'package:flutter/material.dart';
import 'package:websocket_echo/model/message.dart';

class MessageChat extends ChangeNotifier {
  final List<Message> _messages = [];

  MessageChat();

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  List<Message> getMessages() {
    return _messages;
  }
}