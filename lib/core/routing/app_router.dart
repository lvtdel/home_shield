import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/presentation/call/pages/call_page.dart';
import 'package:home_shield/presentation/chat/bloc/chat_cubit.dart';
import 'package:home_shield/presentation/chat/bloc/contact_cubit.dart';
import 'package:home_shield/presentation/chat/pages/chat_page.dart';
import 'package:home_shield/presentation/chat/pages/contact_page.dart';
import 'package:home_shield/presentation/emergency/cubit/emergency_cubit.dart';
import 'package:home_shield/presentation/emergency/pages/emergency_page.dart';
import 'package:home_shield/presentation/group_manage/cubit/group_cubit.dart';
import 'package:home_shield/presentation/group_manage/page/create_group.dart';
import 'package:home_shield/presentation/map/cubit/map_cubit.dart';
import 'package:home_shield/presentation/map/pages/goong_map.dart';
import 'package:home_shield/presentation/map/pages/map.dart';
import 'package:home_shield/presentation/news/bloc/news_bloc.dart';
import 'package:home_shield/presentation/news/pages/news_page.dart';
import 'package:home_shield/presentation/sign_in/cubit/login_cubit.dart';
import 'package:home_shield/presentation/sign_in/pages/sign_in_page.dart';
import 'package:home_shield/presentation/sign_up/cubit/register_cubit.dart';
import 'package:home_shield/presentation/sign_up/pages/sign_up_page.dart';
import 'package:home_shield/presentation/splash/pages/splash_page.dart';

class AppRouter {
  late final router = GoRouter(
      // initialLocation: Routes.news,
      // initialLocation: Routes.contact,
      // initialLocation: Routes.chat,
      // initialLocation: Routes.news,
      //   initialLocation: Routes.signIn,
      initialLocation: Routes.splash,
      routes: [
        GoRoute(path: Routes.splash, builder: (_, __) => SplashPage()),
        GoRoute(
            path: Routes.news,
            builder: (_, __) => BlocProvider(
                  create: (context) => NewsBloc(),
                  child: const NewsPage(),
                )),
        GoRoute(
            path: Routes.signUp,
            builder: (_, __) => BlocProvider(
                  create: (context) => RegisterCubit(),
                  child: SignUpPage(),
                )),
        GoRoute(
            path: Routes.signIn,
            builder: (_, __) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: SignInPage(),
                )),
        GoRoute(
            path: Routes.contact,
            builder: (_, __) => BlocProvider(
                  create: (context) => ContactCubit(),
                  child: const ContactPage(),
                )),
        GoRoute(
            path: Routes.chat,
            builder: (_, state) => BlocProvider(
                  create: (context) => ChatCubit(),
                  child: ChatPage(group: state.extra as Group),
                )),
        // GoRoute(path: Routes.map, builder: (_, __) => FullMap()),
        GoRoute(
            path: Routes.map,
            builder: (_, __) => BlocProvider(
                  create: (context) => MapCubit(),
                  child: MapPage(),
                )),
        GoRoute(path: Routes.call, builder: (_, __) => CallPage()),
        GoRoute(
            path: Routes.createGroup,
            builder: (_, __) => BlocProvider(
                  create: (context) => GroupCubit(),
                  child: CreateGroupPage(),
                )),
        GoRoute(
            path: Routes.emergency,
            builder: (_, __) => BlocProvider(
                  create: (context) => EmergencyCubit(),
                  child: EmergencyPage(),
                )),
      ]);
}
