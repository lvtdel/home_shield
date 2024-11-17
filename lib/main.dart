import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/styles/app_theme.dart';
import 'package:home_shield/presentation/news/bloc/create_news_cubit.dart';
import 'package:home_shield/presentation/news/bloc/news_bloc.dart';
import 'package:home_shield/presentation/notification/cubit/notif_cubit.dart';
import 'package:home_shield/service_locator.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDependencies();

  runApp(const MyApp());

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black, // Màu nền thanh thông báo
  //   statusBarIconBrightness: Brightness.light, // Màu icon trên thanh thông báo
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context)=>NotifCubit()),
        // BlocProvider(create: (context)=>CreateNewsCubit()),
        BlocProvider(create: (context)=>NewsBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
