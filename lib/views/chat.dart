import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_echo/model/connection_model.dart';
import 'package:websocket_echo/model/message.dart';
import 'package:websocket_echo/model/message_model.dart';
import 'package:websocket_echo/routes.dart';
import 'package:websocket_echo/views/components/chat_wall.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller =  TextEditingController();

  void sendMessage() {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    final MessageModel model = context.read<MessageModel>();
    model.addMessage(Message(text, MessageSource.sent, DateTime.now()));
    
    context.read<ConnectionModel>().getChannel().sink.add(text);

    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    try {
      context.read<ConnectionModel>().connect();
      final WebSocketChannel channel = context.read<ConnectionModel>().getChannel();
      final StreamController streamController = StreamController();
      streamController.addStream(channel.stream);

      if (!streamController.hasListener) {
        streamController.stream.listen((event) {
          final MessageModel model = context.read<MessageModel>();
          model.addMessage(Message(event, MessageSource.received, DateTime.now()));
          setState(() {});
        },
        onDone: () {
          if (mounted) {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: const Text("Aviso"),
                content: Text("Conexão encerrada\n\nCódigo:${channel.closeCode}\nMotivo:${channel.closeReason}"),

              );
            });
          }
        });
      }
    } catch (e) {
      context.read<MessageModel>().addMessage(Message("[DEBUG] Erro: ${e.toString()}", MessageSource.received, DateTime.now()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echo Websocket Demo", style: TextStyle(color: Color(0xFFDDDDDD))),
        backgroundColor: const Color(0xFF132443),
        iconTheme: const IconThemeData(color: Color(0xFFDDDDDD)),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF252525),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text("Menu", style: TextStyle(color: Color(0xFFDDDDDD))),
            ),
            ListTile(
              title: const Text("Home", style: TextStyle(color: Color(0xFFDDDDDD))),
              onTap: () {
                GoRouter.of(context).pushReplacement(FEWRouter.chatView);
              },
            ),
            ListTile(
              title: const Text("Config", style: TextStyle(color: Color(0xFFDDDDDD))),
              onTap: () {
                GoRouter.of(context).pushReplacement(FEWRouter.configView);
              },
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xFF252525),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            const MessageWall(),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF132443),
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                              color: Color(0xFFDDDDDD),
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              hintText: "Mensagem",
                              hintStyle: TextStyle(
                                color: Color(0xFF909090)
                              ),
                              border: InputBorder.none,
                              )
                            ),
                        ),
                        ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(Icons.send, color: Color(0xFFDDDDDD)),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF132443)
                        )
                      )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
