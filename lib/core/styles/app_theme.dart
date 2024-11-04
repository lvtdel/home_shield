// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';

import 'app_colors.dart';

/// [AppTheme] contains various custom themes and colors necessary for themes.
/// Themes include:
/// [darkTheme]
/// [lightTheme]
/// These are imported to other files/widgets to apply the required themes.
class AppTheme {
  AppTheme._();

  /// Dark theme for app
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    //primaryTextTheme: AppTextStyle.textTheme,
    //  fontFamily: Constants.fontBeVietNam,
    appBarTheme: AppBarTheme(surfaceTintColor: AppColors.transparent),
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      hintStyle: TextStyle(color: Colors.red),
      filled: true,
      fillColor: Colors.purple,
      errorMaxLines: 3,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  /// Light theme for app
  // static final lightTheme = ThemeData(
  //   useMaterial3: true,
  //   brightness: Brightness.light,
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //   //primaryTextTheme: AppTextStyle.textTheme,
  //   //  fontFamily: Constants.fontBeVietNam,
  //   appBarTheme: AppBarTheme(
  //       surfaceTintColor: AppColors.transparent,
  //     backgroundColor: AppColors.primary
  //   ),
  //   inputDecorationTheme: const InputDecorationTheme(
  //     enabledBorder: InputBorder.none,
  //     disabledBorder: InputBorder.none,
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(4)),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.purple, width: 2),
  //       borderRadius: BorderRadius.all(Radius.circular(4)),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: Colors.purple, width: 2),
  //       borderRadius: BorderRadius.all(Radius.circular(4)),
  //     ),
  //     hintStyle: TextStyle(color: Colors.red),
  //     filled: true,
  //     fillColor: Colors.purple,
  //     errorMaxLines: 3,
  //   ),
  //   bottomSheetTheme: const BottomSheetThemeData(
  //     backgroundColor: Colors.transparent,
  //     surfaceTintColor: Colors.transparent,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(24),
  //         topRight: Radius.circular(24),
  //       ),
  //     ),
  //   ),
  //   checkboxTheme: CheckboxThemeData(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //   ),
  // );
  static final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: AppColors.background, // Màu nền chính cho ứng dụng
        primary: AppColors.primary, // Màu chủ đạo
        secondary: AppColors.white, // Màu phụ
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.background,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      scaffoldBackgroundColor: AppColors.secondBackground,
      // Màu nền phụ cho scaffold

      textTheme: TextTheme(
        displayLarge: AppTextStyle.bold28,
        titleMedium: AppTextStyle.bold18,
        titleSmall: AppTextStyle.regular16,
        bodyLarge: AppTextStyle.regular18,
        bodyMedium: AppTextStyle.regular16,
        bodySmall: AppTextStyle.regular14,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.transparent, // AppBar sẽ có màu chủ đạo
        surfaceTintColor: AppColors.transparent,
        iconTheme: IconThemeData(color: Colors.black), // Màu biểu tượng
        titleTextStyle: TextStyle(
            // fontFamily: 'poppins',
            color: Colors.black,
            fontSize: 20), // Màu và kiểu chữ tiêu đề
      ),

      // inputDecorationTheme: const InputDecorationTheme(
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: AppColors.primary),
      //     // Border khi không được focus
      //     borderRadius: BorderRadius.all(Radius.circular(4)),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: AppColors.primary, width: 2),
      //     // Border khi được focus
      //     borderRadius: BorderRadius.all(Radius.circular(4)),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.red, width: 2), // Màu khi có lỗi
      //     borderRadius: BorderRadius.all(Radius.circular(4)),
      //   ),
      //   hintStyle: TextStyle(color: Colors.grey),
      //   // Màu chữ gợi ý
      //   filled: true,
      //   fillColor: AppColors.secondBackground, // Màu nền cho input khi được điền
      // ),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: AppTextStyle.regular16,
          border: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(16.0), // Độ cong bo tròn
              // borderSide: BorderSide(
              //   color: Colors.grey, // Màu viền mặc định
              // ),
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.primary, // Màu viền khi `TextField` được chọn
              width: 2.0, // Độ dày của viền khi được chọn
            ),
          )),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.secondBackground, // Màu nền bottom sheet
        surfaceTintColor: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fillColor: MaterialStateProperty.all(
            AppColors.primary), // Màu cho checkbox khi được chọn
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Màu nền của ElevatedButton
          foregroundColor: Colors.white, // Màu chữ
          shape: AppShapes.roundedRectangle40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary, // Màu chữ
          shape: AppShapes.roundedRectangle40,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primary, width: 1.5),
          // Viền của OutlinedButton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Độ bo tròn của nút
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        // Màu nền của FAB
        foregroundColor: AppColors.white,
        // Màu biểu tượng của FAB
        shape: AppShapes.circle,
        elevation: 8.0,
        // Độ cao bóng đổ
        sizeConstraints: const BoxConstraints.tightFor(
          width: 56.0, // Chiều rộng tùy chỉnh
          height: 56.0, // Chiều cao tùy chỉnh
        ),
      ),
      cardTheme: CardTheme(
          shape: AppShapes.roundedRectangle40, elevation: AppSize.s8));
}
