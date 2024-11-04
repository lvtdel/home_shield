// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

import 'app_font_family.dart';

/// [AppTextStyle] contains various custom text style.
///
/// Type of text style:
/// 1. regular
/// 2. bold
class AppTextStyle {
  AppTextStyle._();

  // regular style

  static final TextStyle regular9 = regularStyle.copyWith(fontSize: 9);

  static final TextStyle regular10 = regularStyle.copyWith(fontSize: 10);

  static final TextStyle regular11 = regularStyle.copyWith(fontSize: 11);

  static final TextStyle regular12 = regularStyle.copyWith(fontSize: 12);

  static final TextStyle regular13 = regularStyle.copyWith(fontSize: 13);

  static final TextStyle regular14 = regularStyle.copyWith(fontSize: 14);

  static final TextStyle regular15 = regularStyle.copyWith(fontSize: 15);

  static final TextStyle regular16 = regularStyle.copyWith(fontSize: 16);

  static final TextStyle regular18 = regularStyle.copyWith(fontSize: 18);

  static final TextStyle regular19 = regularStyle.copyWith(fontSize: 19);

  static final TextStyle regular20 = regularStyle.copyWith(fontSize: 20);

  static final TextStyle regular22 = regularStyle.copyWith(fontSize: 22);

  static final TextStyle regular24 = regularStyle.copyWith(fontSize: 24);

  static final TextStyle regular26 = regularStyle.copyWith(fontSize: 26);

  static final TextStyle regular28 = regularStyle.copyWith(fontSize: 28);

  // bold style
  static final TextStyle bold9 = boldStyle.copyWith(fontSize: 9);

  static final TextStyle bold10 = boldStyle.copyWith(fontSize: 10);

  static final TextStyle bold11 = boldStyle.copyWith(fontSize: 11);

  static final TextStyle bold12 = boldStyle.copyWith(fontSize: 12);

  static final TextStyle bold13 = boldStyle.copyWith(fontSize: 13);

  static final TextStyle bold14 = boldStyle.copyWith(fontSize: 14);

  static final TextStyle bold15 = boldStyle.copyWith(fontSize: 15);

  static final TextStyle bold16 = boldStyle.copyWith(fontSize: 16);

  static final TextStyle bold18 = boldStyle.copyWith(fontSize: 18);

  static final TextStyle bold19 = boldStyle.copyWith(fontSize: 19);

  static final TextStyle bold20 = boldStyle.copyWith(fontSize: 20);

  static final TextStyle bold22 = boldStyle.copyWith(fontSize: 22);

  static final TextStyle bold24 = boldStyle.copyWith(fontSize: 24);

  static final TextStyle bold26 = boldStyle.copyWith(fontSize: 26);

  static final TextStyle bold28 = boldStyle.copyWith(fontSize: 28);

  // regular style no scare

  static final TextStyle boldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle regularStyle = _textStyleRegular;

  static final TextStyle _textStyle = TextStyle(
    fontFamily: AppFontFamily().getFontFamily(),
  );
  static final TextStyle _textStyleRegular = TextStyle(
    fontFamily: AppFontFamily().getFontFamily(),
    fontWeight: FontWeight.w400
  );
}
