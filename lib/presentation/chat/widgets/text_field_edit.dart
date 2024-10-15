import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/chat/widgets/circle_item.dart';

class TextFieldEdit extends StatelessWidget {
  const TextFieldEdit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none, // Không có đường viền
    );

    return TextField(
      style: Theme.of(context).textTheme.bodySmall,
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        filled: true, // Tùy chọn, giúp làm nổi bật nền của TextField
        fillColor: Theme.of(context).colorScheme.secondary, // Màu nền khi filled: true
        suffixIcon: 
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p10),
            child: circleContainer(context, FontAwesomeIcons.paperPlane))
      ),
    );
  }
}
