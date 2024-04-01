import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_echo/model/connection_model.dart';
import 'package:websocket_echo/model/message_model.dart';
import 'routes.dart';

class FlutterEchoWebsocketApp extends StatelessWidget {
  const FlutterEchoWebsocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MessageModel>(create: (context) => MessageModel()),
        ChangeNotifierProvider<ConnectionModel>(create: (context) => ConnectionModel())
      ],
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: "Echo Websocket Demo",
        );
      }
    );
  }
}
