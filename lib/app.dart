import 'package:flutter/material.dart';
import 'routes.dart';

class FlutterEchoWebsocketApp extends StatelessWidget {
  const FlutterEchoWebsocketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: "Echo Websocket Demo",
    );
  }
}
