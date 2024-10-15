

import 'dart:ui';

/// {@template app_font_family}
/// Get font family using in app based on device type, OS type
/// {@endtemplate}
class AppFontFamily {
  /// Source Han Sands
  late final String appFont;
  late final String appFontRegular;

  /// {@macro app_font_family}
  AppFontFamily() {
    appFont = "Poppins"; // TODO: Add font name's variable
    appFontRegular = "Poppins-regular";
  }

  /// Get font family based on device type, OS type
  /// Mobile size: Size(375, 718)
  /// Tablet size: Size(744, 1113)
  ///
  /// Calculate mobile and tablet device type base screen size
  ///
  /// if ((orientation == Orientation.portrait && screenWidth < 600) ||
  ///   (orientation == Orientation.landscape && screenHeight < 600)) {
  ///   deviceType = DeviceType.mobile;
  /// } else {
  ///   deviceType = DeviceType.tablet;
  /// }
  String getFontFamily() {
    return appFont;
  }
}
