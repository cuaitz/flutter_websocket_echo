import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_echo/model/message.dart';
import 'package:websocket_echo/model/message_model.dart';
import 'package:websocket_echo/views/components/chat_message.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final MessageModel _chat = MessageModel();

  final TextEditingController _controller =  TextEditingController();

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events')
  );

  void sendMessage() {
    String text = _controller.text.trim();

    if (text.isEmpty) return;

    _chat.addMessage(Message(text, MessageSource.sent));
    _controller.clear();
    
    channel.sink.add(text);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    channel.stream.listen((event) {
      _chat.addMessage(Message(event, MessageSource.received));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echo Websocket Demo", style: TextStyle(color: Color(0xFFDDDDDD))),
        backgroundColor: const Color(0xFF132443),
      ),
      backgroundColor: const Color(0xFF252525),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: _chat.getMessages().map((message) {
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(message.message, style: const TextStyle(fontSize: 16, color: Color(0xFFDDDDDD))),
                                ),
                              ),
                            ),
                          ),
                        );
                        }).toList()
                  ),
                ),
              ),
            ),
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
