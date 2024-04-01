import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_echo/model/message_model.dart';
import 'routes.dart';

class FlutterEchoWebsocketApp extends StatelessWidget {
  const FlutterEchoWebsocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageModel(),
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
