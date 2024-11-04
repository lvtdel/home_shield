import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/widgets/text_field_edit.dart';
import 'package:home_shield/res/assets_res.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  _onLogin() {
    context.go(Routes.news);
  }

  _onGoogleLogin() {
    print("Google click");
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
                  child: ElevatedButton(
                      onPressed: _onLogin,
                      child: Text(
                        "Login",
                        style: AppTextStyle.bold22,
                      ))),
              const SizedBox(
                height: 20,
              ),
               Text("Forgot password?", style: Theme.of(context).textTheme.titleSmall,),
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
                  SizedBox(
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
