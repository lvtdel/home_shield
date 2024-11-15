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

class CreateGroupPage extends StatefulWidget {
  CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = "votheluc01@gmail.com";
    // passwordController.text = "abba1221";

    super.initState();
  }

  _onCreate() {
    String name = nameController.text;
    List<String> otherMemberEmails = memberControllers
        .map((controller) => controller.text)
        .where((e) => e.isNotEmpty)
        .toList();

    if (name.isEmpty) {
      showSnackBar(context, "Let fill name of group");
      return;
    }

    if (otherMemberEmails.isEmpty) {
      showSnackBar(context, "Let add member");
      return;
    }

    if (imagePick == null) {
      showSnackBar(context, "Let add avatar for group");
      return;
    }

    context.read<GroupCubit>().createGroup(name, imagePick!, otherMemberEmails);
  }


  Widget _createButton() {
    return BlocBuilder<GroupCubit, GroupState>(builder: (context, state) {
      if (state is GroupInitial) {
      return ElevatedButton(
          onPressed: _onCreate,
          child: Text(
            "Create group",
            style: AppTextStyle.bold22,
          ));
      }

      if (state is LoadingGroup) {
        return ElevatedButton(
            onPressed: () {},
            child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                )));
      }

      if (state is GroupSuccess) {
        showSnackBar(context, "Welcome ${state.groupName}");

        Timer(const Duration(seconds: 1), () {
          context.go(Routes.news);
        });

        return ElevatedButton(
            onPressed: () {},
            child: Text(
              "Create group",
              style: AppTextStyle.bold22,
            ));
      }

      if (state is GroupError) {
        showSnackBar(context, state.mess);

        return ElevatedButton(
            onPressed: _onCreate,
            child: Text(
              "Create group",
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
                    "Create",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              _buildAvatar(),
              const SizedBox(
                height: 90,
              ),
              textFieldEdit(
                  AssetsRes.EMAIL_ICON, "Enter group name", nameController),
              const SizedBox(height: 20),
              ...memberList,
              const SizedBox(height: 20),
              Container(
                  decoration: AppShapes.inputBoxDecoration,
                  height: AppSize.s60,
                  width: AppSize.s340,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              AppColors.secondBackground)),
                      onPressed: _onAddMem,
                      child: Text(
                        "Add member",
                        style:
                            AppTextStyle.bold18.copyWith(color: Colors.black),
                      ))),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: AppShapes.inputBoxDecoration,
                  height: AppSize.s60,
                  width: AppSize.s340,
                  child: _createButton()),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onAddMem() {
    memberControllers.add(TextEditingController());
    memberList.add(textFieldEdit(
        AssetsRes.EMAIL_ICON, "Enter email member", memberControllers.last));
    setState(() {});
  }

  List<Widget> memberList = [];
  List<TextEditingController> memberControllers = [];

  _buildAvatar() {
    return GestureDetector(
        onTap: () async {
          final image =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (image != null) {
            setState(() {
              imagePick = File(image.path);
            });
          }
        },
        child: _avatar(AssetsRes.FACEBOOK_ICON, 150, context));
  }

  File? imagePick;

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
        child: imagePick != null
            ? Image.file(
                imagePick!,
                fit: BoxFit.cover,
              )
            : Image.asset(AssetsRes.AVATAR_SAMPLE),
      ),
    );
  }
}
