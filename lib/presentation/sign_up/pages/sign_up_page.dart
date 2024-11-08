import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/presentation/sign_up/cubit/register_cubit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:home_shield/presentation/widgets/text_field_edit.dart';
import 'package:home_shield/res/assets_res.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  void initState() {
    nameController.text = "Vo The Luc";
    emailController.text = "votheluc01@gmail.com";
    phoneController.text = "0915941872";
    passwordController.text = "abba1221";
    rePasswordController.text = "abba1221";

    super.initState();
  }

  _onRegister() {
    final pass = passwordController.text;
    final rePass = rePasswordController.text;
    final name = nameController.text;
    final email = emailController.text;
    final phoneNumber = phoneController.text;

    if (email.isEmpty || name.isEmpty || pass.isEmpty) {
      showSnackBar(context, "Please enter name, email and password");
      return;
    }

    if (pass != rePass) {
      showSnackBar(context, "Password not match");
      return;
    }

    UserApp user = UserApp(
        name: name, email: email, password: pass, phoneNumber: phoneNumber);

    context.read<RegisterCubit>().register(user);
  }

  _registerButton(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      if (state is RegisterInitial) {
        return ElevatedButton(
            onPressed: _onRegister,
            child: Text(
              "Register",
              style: AppTextStyle.bold22,
            ));
      }

      if (state is RegisterLoading) {
        return ElevatedButton(
            onPressed: () {},
            child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                )));
      }

      if (state is RegisterSuccess) {
        showSnackBar(context, "Register success");

        Timer(const Duration(seconds: 1), () {
          context.go(Routes.signIn);
        });

        return ElevatedButton(
            onPressed: () {},
            child: Text(
              "Register",
              style: AppTextStyle.bold22,
            ));
      }

      if (state is RegisterError) {
        showSnackBar(context, state.mess);

        return ElevatedButton(
            onPressed: _onRegister,
            child: Text(
              "Register",
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
                  AssetsRes.LOCK_ICON, "Enter password", passwordController,
                  obscure: true),
              const SizedBox(
                height: 20,
              ),
              textFieldEdit(
                  AssetsRes.LOCK_ICON, "Confirm password", rePasswordController,
                  obscure: true),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: AppShapes.inputBoxDecoration,
                  height: AppSize.s60,
                  width: AppSize.s340,
                  child: _registerButton(context)),
              const SizedBox(
                height: 30,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleSmall),
                TextSpan(
                    text: "Sign in",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
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
