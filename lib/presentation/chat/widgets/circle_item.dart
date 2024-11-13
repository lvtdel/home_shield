import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_values.dart';

Widget circleContainer(BuildContext context, IconData iconData,
    {double size = AppSize.s45, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          iconData,
          color: AppColors.white,
          size: 20,
        ),
      ),
    ),
  );
}
