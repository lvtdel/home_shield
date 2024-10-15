import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_values.dart';

class AppShapes {
  AppShapes._();

  static final RoundedRectangleBorder roundedRectangle40 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  );

  static final RoundedRectangleBorder roundedRectangle30 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  );

  static final CircleBorder circle = CircleBorder(); // Hình tròn

  static final BeveledRectangleBorder beveledRectangle = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Bo góc 10 pixel
  );
}
