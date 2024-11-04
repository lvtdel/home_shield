import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_values.dart';

class AppShapes {
  AppShapes._();

  static final RoundedRectangleBorder roundedRectangle40 =
  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  );

  static final RoundedRectangleBorder roundedRectangle30 =
  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40),
  );

  static final BoxDecoration inputBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(32),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3), // Màu bóng
        spreadRadius: 1, // Độ lan tỏa của bóng
        blurRadius: 8, // Độ mờ của bóng
        offset: Offset(0, 4), // Đặt vị trí của bóng
      ),
    ],
  );


  static final CircleBorder circle = CircleBorder(); // Hình tròn

  static final BeveledRectangleBorder beveledRectangle = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Bo góc 10 pixel
  );

  static const threeRoundedRectangle1 = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ));

  static const threeRoundedRectangle2 = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ));
}
