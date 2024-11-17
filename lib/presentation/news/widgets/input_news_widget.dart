import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/presentation/news/bloc/create_news_cubit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:home_shield/res/assets_res.dart';
import 'package:image_picker/image_picker.dart';

class InputNewsWidget extends StatefulWidget {
  InputNewsWidget(this.userApp, this.image, {super.key});

  final UserApp userApp;
  String? image;

  @override
  State<InputNewsWidget> createState() => _InputNewsWidgetState();
}

class _InputNewsWidgetState extends State<InputNewsWidget> {
  final contentController = TextEditingController();
  File? imagePick;

  _onPost() {
    String content = contentController.text;
    File? imageFile = imagePick;

    if (content.isEmpty && imageFile == null) {
      showSnackBar(context, "Empty content");
      return;
    }

    context
        .read<CreateNewsCubit>()
        .createNews(content, imageFile, widget.image);
  }

  _onCancel() {
    context.pop();
  }

  _onCreateImage() {
    String content = contentController.text;

    if (content.isEmpty) {
      showSnackBar(context, "Nothing description to create image");
    }

    context.read<CreateNewsCubit>().generateImage(content);
  }

  _onCreateDescription() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: <Widget>[
          _headerPost(context),
          _content(context),
          SizedBox(
            height: 10,
          ),
          _aiButton(),
          SizedBox(
            height: 20,
          ),
          _image(),
          const SizedBox(
            height: 20,
          ),
          _footer()
        ],
      ),
    );
  }

  _aiButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: 50,
            // width: 150,
            child: ElevatedButton(
                onPressed: _onCreateImage,
                child: Text(
                  "Create image",
                  style: AppTextStyle.bold18,
                ))),
        SizedBox(
            height: 50,
            // width: 150,
            child: ElevatedButton(
                onPressed: _onCreateDescription,
                child: Text(
                  "Create description",
                  style: AppTextStyle.bold18,
                )))
      ],
    );
  }

  _content(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
      child: TextField(
        decoration: InputDecoration(hintText: "How are you today?"),
        maxLines: 5,
        controller: contentController,
      ),
    );
  }

  Widget _image() {
    return GestureDetector(
        onTap: () async {
          final image =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          if (image != null) {
            setState(() {
              widget.image = null;
              imagePick = File(image.path);
            });
          }
        },
        child: Container(
          decoration: ShapeDecoration(shape: AppShapes.roundedRectangle30),
          clipBehavior: Clip.antiAlias,
          child: Stack(children: [
            if (widget.image != null)
              Image.network(
                widget.image!,
                fit: BoxFit.cover,
                height: 300,
              )
            else
              (imagePick == null)
                  ? Image.asset(
                      AssetsRes.UPLOAD_SAMPLE,
                      fit: BoxFit.cover,
                      height: 300,
                    )
                  : Image.file(
                      imagePick!,
                      fit: BoxFit.cover,
                      height: 300,
                      // width: 300,
                    ),
          ]),
        ));
  }

  Padding _headerPost(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.userApp.image!))),
                ),
                const SizedBox(width: 10.0),
                Text(
                  widget.userApp.name!,
                  // style: TextStyle(fontWeight: FontWeight.bold),
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ]),
    );
  }

  _footer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
                onPressed: _onPost,
                child: Text(
                  "Post",
                  style: AppTextStyle.bold18,
                ))),
        SizedBox(
            height: 50,
            width: 150,
            child: TextButton(
                onPressed: _onCancel,
                child: Text(
                  "Cancel",
                  style: AppTextStyle.bold18,
                )))
      ],
    );
  }
}
