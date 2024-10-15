// ignore_for_file: unused_field, public_member_api_docs

import 'dart:math';

import 'package:flutter/material.dart';

/// [AppColors] contains various the color.
/// These are imported to other files/widgets to apply the required colors.
///
/// Acronyms included in color variables:
///
/// Linear gradient color:
class AppColors {
  AppColors._();

  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static final Color blackOpacity = Colors.black.withOpacity(.15);

  static const primary = Color(0xff5790DF);
  static const background = Color(0xffE6EEFA);
  // static const secondBackground = Color(0xff342F3F);
  static const secondBackground = Colors.white;
}
