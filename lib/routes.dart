import 'package:go_router/go_router.dart';
import 'package:websocket_echo/views/config_view.dart';
import '/views/chat.dart';

class FEWRouter {
  static const String chatView = '/';
  static const String configView = '/config';
}

final GoRouter router = GoRouter(
  initialLocation: FEWRouter.chatView,
  routes: [
    GoRoute(
      path: FEWRouter.chatView,
      name: FEWRouter.chatView,
      builder: (context, state) => const ChatView(),
    ),
    GoRoute(
      path: FEWRouter.configView,
      name: FEWRouter.configView,
      builder: (context, state) => const ConfigView(),
    )
  ]
);
