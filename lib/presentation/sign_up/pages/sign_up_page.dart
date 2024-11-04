import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/widgets/text_field_edit.dart';
import 'package:home_shield/res/assets_res.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

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
                    "Sign Up",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset(AssetsRes.LOGO),
              const SizedBox(
                height: 40,
              ),
              textFieldEdit(
                  AssetsRes.ACCOUNT_ICON, "Enter your name", nameController),
              const SizedBox(
                height: 20,
              ),
              textFieldEdit(
                  AssetsRes.EMAIL_ICON, "Enter email", emailController),
              const SizedBox(
                height: 20,
              ),
              textFieldEdit(AssetsRes.PHONE_ICON, "Enter your phone number",
                  phoneController),
              const SizedBox(
                height: 20,
              ),
              textFieldEdit(
                  AssetsRes.LOCK_ICON, "Enter password", passwordController, obscure: true),
              const SizedBox(
                height: 20,
              ),
              textFieldEdit(AssetsRes.LOCK_ICON, "Confirm password",
                  rePasswordController, obscure: true),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: AppShapes.inputBoxDecoration,
                  height: AppSize.s60,
                  width: AppSize.s340,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Register",
                        style: AppTextStyle.bold22,
                      ))),
              const SizedBox(
                height: 30,
              ),
              Text.rich(TextSpan(children: [
                const TextSpan(text: "Already have an account? "),
                TextSpan(
                    text: "Sign in",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.go(Routes.signIn);
                      })

              ]))
            ],
          ),
        ),
      ),
    );
  }
}
