import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionModel extends ChangeNotifier {
  Uri _websocketUri = Uri.parse("wss://echo.websocket.events");  // Default
  late WebSocketChannel _channel;
  
  ConnectionModel() {
    connect();
  }

  void connect() {
    _channel = WebSocketChannel.connect(_websocketUri);
  }

  void setUri(Uri uri) {
    _websocketUri = uri;
    connect();
  }

  WebSocketChannel getChannel() {
    return _channel;
  }

  bool isOpen() {
    return _channel.closeCode != null;
  }
}