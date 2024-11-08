import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/domain/auth/repository/auth.dart';
import 'package:home_shield/res/assets_res.dart';
import 'package:home_shield/service_locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
      if (await sl<AuthRepository>().isLoggedIn()) {
        context.go(Routes.news);
      } else {
        context.go(Routes.signIn);
      };
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetsRes.LOGO),
      ),
    );
  }
}
