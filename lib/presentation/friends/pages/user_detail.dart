import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/data/chat/models/group_model.dart';
import 'package:home_shield/domain/auth/use_cases/sign_up.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/presentation/group_manage/cubit/group_cubit.dart';
import 'package:home_shield/presentation/group_manage/cubit/group_cubit.dart';
import 'package:home_shield/presentation/sign_in/cubit/login_cubit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:home_shield/presentation/widgets/text_field_edit.dart';
import 'package:home_shield/res/assets_res.dart';
import 'package:home_shield/service_locator.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();

  final UserApp user;
}

class _UserDetailPageState extends State<UserDetailPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.user.phoneNumber ?? "";
    emailController.text = widget.user.email!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 32),
                    child: Text(
                      "Create",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                _avatar(AssetsRes.FACEBOOK_ICON, 150, context),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.user.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                textDisable(
                    AssetsRes.PHONE_ICON, "Phone number", nameController),
                const SizedBox(
                  height: 20,
                ),
                textDisable(
                    AssetsRes.EMAIL_ICON, "email", emailController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _item(icon: Icons.bloodtype, text: widget.user.bloodType?? "NA", onTap: (){context.push(Routes.contact);}),
                    _item(icon: Icons.supervisor_account_rounded, text: "8")
                  ],
                ),

              ],
            ),]
          ),
        ),
      ),
    );
  }

  Container _avatar(String image, double size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: Theme.of(context).primaryColor)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(shape: AppShapes.circle),
        margin: const EdgeInsets.all(AppPadding.p5),
        height: size,
        width: size,
        child: widget.user.image != null
            ? Image.network(
                widget.user.image!,
                fit: BoxFit.cover,
              )
            : Image.asset(AssetsRes.AVATAR_SAMPLE),
      ),
    );
  }
}

textDisable(String image, String? hintText, controller, {bool obscure = false, enable = true}) {
  return Container(
      width: AppSize.s340,
      height: AppSize.s60,
      decoration: AppShapes.inputBoxDecoration,
      child: TextField(
        readOnly: true,
        // style: AppTextStyle.regular16,
        enabled: enable,
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image, width: 30,height: 30,)),
            hintText: hintText),
      ));
}

_item({required IconData icon, required String text, Color? color, onTap}) {
  return Container(
    margin: const EdgeInsets.all(AppPadding.p15),
    decoration: AppShapes.inputBoxDecoration,

    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSize.s130,
        height: AppSize.s130,
        // decoration: AppShapes.inputBoxDecoration,
        margin: const EdgeInsets.all(3),
        // decoration: AppShapes.inputBoxDecoration,
        decoration: AppShapes.inputBoxDecoration.copyWith(
            color: color ?? AppColors.primary),
        // decoration: ,
        // color: AppColors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSize.s40,
              color: AppColors.white,
            ),
            const SizedBox(height: 5,),
            Text(text,
                style: AppTextStyle.bold20.copyWith(color: AppColors.white))
          ],
        ),
      ),
    ),
  );
}
