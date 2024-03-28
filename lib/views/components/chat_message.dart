import 'package:flutter/material.dart';

class ChatMessageStyle {
  final Color backgroundColor;
  final Alignment alignment;

  ChatMessageStyle(this.backgroundColor, this.alignment);

  static final sentMessage = ChatMessageStyle(const Color(0xFF132443), Alignment.centerRight);
  static final receivedMessage = ChatMessageStyle(const Color(0xFF404040), Alignment.centerLeft);
}
