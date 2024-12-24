import 'dart:io' show Platform;
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_shield/common/emergency/emer_global_bloc.dart';
import 'package:home_shield/common/emergency/emer_global_widget.dart';
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

  if (Platform.isAndroid) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
      print("This is caught by PlatformDispatcher.instance.onError ${error}");

      return true;
    };
  }



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
        BlocProvider(create: (context) => NotifCubit()),
        // BlocProvider(create: (context)=>CreateNewsCubit()),
        BlocProvider(create: (context) => NewsBloc()),
        BlocProvider(create: (context) => EmerGlobalBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return EmerGlobal(
            child: child!,
          );
        },
      ),
    );
  }
}
