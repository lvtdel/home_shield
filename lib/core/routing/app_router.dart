import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/presentation/chat/pages/chat_page.dart';
import 'package:home_shield/presentation/chat/pages/contact_page.dart';
import 'package:home_shield/presentation/news/pages/news_page.dart';
import 'package:home_shield/presentation/sign_in/cubit/login_cubit.dart';
import 'package:home_shield/presentation/sign_in/pages/sign_in_page.dart';
import 'package:home_shield/presentation/sign_up/pages/sign_up_page.dart';

class AppRouter {
  late final router = GoRouter(
      // initialLocation: Routes.news,
      // initialLocation: Routes.contact,
      // initialLocation: Routes.chat,
      // initialLocation: Routes.news,
      initialLocation: Routes.signIn,
      routes: [
        GoRoute(path: Routes.news, builder: (_, __) => NewsPage()),
        GoRoute(path: Routes.signUp, builder: (_, __) => SignUpPage()),
        GoRoute(
            path: Routes.signIn,
            builder: (_, __) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: SignInPage(),
                )),
        GoRoute(path: Routes.contact, builder: (_, __) => ContactPage()),
        GoRoute(path: Routes.chat, builder: (_, __) => ChatPage()),
      ]);
}
