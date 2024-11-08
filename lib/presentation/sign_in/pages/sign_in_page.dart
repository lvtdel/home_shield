import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/presentation/sign_in/cubit/login_cubit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:home_shield/presentation/widgets/text_field_edit.dart';
import 'package:home_shield/res/assets_res.dart';
import 'package:home_shield/service_locator.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    emailController.text = "votheluc01@gmail.com";
    passwordController.text = "abba1221";

    super.initState();
  }

  _onLogin() {
    String email = emailController.text;
    String pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty) throw Exception("Validate failed!");

    context.read<LoginCubit>().login(email, pass);
  }

  _onGoogleLogin() {
    print("Google click");
  }

  Widget _logInButton() {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginInitial) {
        return ElevatedButton(
            onPressed: _onLogin,
            child: Text(
              "Login",
              style: AppTextStyle.bold22,
            ));
      }

      if (state is LoadingLogin) {
        return ElevatedButton(
            onPressed: () {},
            child: const SizedBox(
                height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white,)));
      }

      if (state is LoginSuccess) {
        showSnackBar(context, "Welcome ${state.userName}");

        Timer(const Duration(seconds: 1), () {
          context.go(Routes.news);
        });

        return ElevatedButton(
            onPressed: () {},
            child: Text(
              "Login",
              style: AppTextStyle.bold22,
            ));
      }

      if (state is LoginError) {
        showSnackBar(context, "state.mess");

        return ElevatedButton(
            onPressed: _onLogin,
            child: Text(
              "Login",
              style: AppTextStyle.bold22,
            ));
      }

      return Text("Undefined state ${state.runtimeType}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 32),
                  child: Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Image.asset(AssetsRes.LOGO),
              const SizedBox(
                height: 90,
              ),
              textFieldEdit(
                  AssetsRes.EMAIL_ICON, "Enter email", emailController),
              const SizedBox(height: 20),
              textFieldEdit(
                  AssetsRes.LOCK_ICON, "Enter password", passwordController,
                  obscure: true),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: AppShapes.inputBoxDecoration,
                  height: AppSize.s60,
                  width: AppSize.s340,
                  child: _logInButton()),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Forgot password?",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(AssetsRes.GOOGLE_ICON),
                    onTap: _onGoogleLogin,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Image.asset(AssetsRes.FACEBOOK_ICON),
                    onTap: _onGoogleLogin,
                  ),
                  // GestureDetector(
                  //   onTap: _onGoogleLogin,
                  //     child: Image.asset(AssetsRes.GOOGLE_ICON)),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // Image.asset(AssetsRes.FACEBOOK_ICON)
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Don’t have an account? ",
                    style: Theme.of(context).textTheme.titleSmall),
                TextSpan(
                    text: "Sign up",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.go(Routes.signUp);
                      })
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
