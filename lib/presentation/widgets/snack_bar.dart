import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String mess) {
  Future.delayed(const Duration(milliseconds: 100), () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mess,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  });
}
