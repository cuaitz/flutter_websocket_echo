import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:websocket_echo/model/message.dart';

class ChatMessageStyle {
  final Color backgroundColor;
  final Alignment alignment;

  ChatMessageStyle(this.backgroundColor, this.alignment);

  static final sentMessage = ChatMessageStyle(const Color(0xFF132443), Alignment.centerRight);
  static final receivedMessage = ChatMessageStyle(const Color(0xFF404040), Alignment.centerLeft);
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.message});

  final Message message;
  
  @override
  Widget build(BuildContext context) {
    ChatMessageStyle messageStyle = message.source == MessageSource.sent 
      ? ChatMessageStyle.sentMessage 
      : ChatMessageStyle.receivedMessage;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: messageStyle.alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 3/4),
          child: Container(
            decoration: BoxDecoration(
              color: messageStyle.backgroundColor,
              borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
              crossAxisAlignment: messageStyle.alignment == Alignment.centerRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message.message, style: const TextStyle(fontSize: 16, color: Color(0xFFDDDDDD))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Text(DateFormat('HH:mm').format(message.date), style: const TextStyle(fontSize: 12, color: Color(0xFF707070))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}