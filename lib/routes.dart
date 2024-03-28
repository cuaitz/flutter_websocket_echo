import 'package:go_router/go_router.dart';
import '/views/chat.dart';

class FEWRouter {
  static const String chatView = '/';
}

final GoRouter router = GoRouter(
  initialLocation: FEWRouter.chatView,
  routes: [
    GoRoute(
      path: FEWRouter.chatView,
      name: FEWRouter.chatView,
      builder: (context, state) => const ChatView(),
    )
  ]
);
