import 'dart:io';

class UI {
  /// System.
  static bool isDesktop =
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  static bool isMobile = Platform.isIOS || Platform.isAndroid;

  /// Fonts.
  static double get fontSizeXSmall => isDesktop ? 10 : 12;
  static double get fontSizeSmall => isDesktop ? 12 : 14;
  static double get fontSizeMedium => isDesktop ? 14 : 16;
  static double get fontSizeLarge => isDesktop ? 18 : 20;

  /// Misc.
  static const double badgeSize = 10;
}
