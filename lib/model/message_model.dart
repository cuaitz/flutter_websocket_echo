import 'package:flutter/material.dart';
import 'package:websocket_echo/model/message.dart';

class MessageModel extends ChangeNotifier {
  final List<Message> _messages = [];

  MessageModel();

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  List<Message> getMessages() {
    return _messages;
  }
}