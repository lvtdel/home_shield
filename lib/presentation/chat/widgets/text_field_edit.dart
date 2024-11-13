import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/chat/bloc/chat_cubit.dart';
import 'package:home_shield/presentation/chat/widgets/circle_item.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';

class TextFieldEdit extends StatelessWidget {
  final Function1<String, Future<bool>>? onSend;
  final textController = TextEditingController();

  TextFieldEdit({super.key, this.onSend});

  _onSendClick(BuildContext context) async {
    String content = textController.text;
    if (content.isEmpty) {
      return;
    }

    if (onSend != null) {
      if (await onSend!(content)) {
        textController.text = "";
      } else {
        showSnackBar(context, "Send error, please try again");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none, // Không có đường viền
    );

    return TextField(
      controller: textController,
      minLines: 1,
      maxLines: null,
      style: Theme.of(context).textTheme.bodySmall,
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          filled: true,
          // Tùy chọn, giúp làm nổi bật nền của TextField
          fillColor: Theme.of(context).colorScheme.secondary,
          // Màu nền khi filled: true
          suffixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p10),
              child: circleContainer(context, FontAwesomeIcons.paperPlane,
                  onTap: () {
                _onSendClick(context);
              }))),
    );
  }
}
