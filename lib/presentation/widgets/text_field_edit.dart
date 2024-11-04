import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';

textFieldEdit(String image, String? hintText, controller, {bool obscure = true}) {
  return Container(
      width: AppSize.s340,
      decoration: AppShapes.inputBoxDecoration,
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image)),
            hintText: hintText),
      ));
}
