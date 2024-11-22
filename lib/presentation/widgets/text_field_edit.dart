import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';

textFieldEdit(String image, String? hintText, controller, {bool obscure = false, enable = true}) {
  return Container(
      width: AppSize.s340,
      height: AppSize.s60,
      decoration: AppShapes.inputBoxDecoration,
      child: TextField(
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
