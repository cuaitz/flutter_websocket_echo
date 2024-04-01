import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_echo/model/message_model.dart';
import 'package:websocket_echo/views/components/chat_message.dart';

class MessageWall extends StatelessWidget {
  const MessageWall({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageModel>(
      builder: (context, model, child) {
        return Flexible(
          child: Scrollbar(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: model.getMessages().map((message) => ChatMessage(message: message)).toList()
              ),
            ),
          ),
        );
      }
    );
  }
}