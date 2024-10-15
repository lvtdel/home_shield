import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/presentation/chat/pages/chat_page.dart';
import 'package:home_shield/presentation/chat/pages/contact_page.dart';
import 'package:home_shield/presentation/news/pages/news_page.dart';

class AppRouter {
  late final router = GoRouter(
      // initialLocation: Routes.news,
      // initialLocation: Routes.chat,
      initialLocation: Routes.news,
      routes: [
        GoRoute(path: Routes.news, builder: (_, __) => NewsPage()),
        GoRoute(path: Routes.contact, builder: (_, __) => ContactPage()),
        GoRoute(path: Routes.chat, builder: (_, __) => ChatPage()),
      ]);
}
