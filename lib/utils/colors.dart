import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const whitecolor = Colors.white;
  static const blackcolor = AppColors.primaryBlue;
  static const grayColor = Color(0xFFDDDDDD);
  static const green = Color(0xFF008F88);
  static const newgreen = Color(0xFF2DCE89);
  // static const newgreen = Color(0xFF46AF46);
  static const blue = Color(0xFF1D1D3D);
  static const wrappBGB = Color.fromARGB(255, 57, 57, 58);
  static final Color lightGrey = Color(0xffAAB8C2);
  static final Color extraLightGrey = Color(0xFFE7E7EE);
  static final Color extraExtraLightGrey = Color(0xfF5F8FA);

  static const Color primaryText = Color(0xFF32325D);

  static const Color secondarytext = Color(0xFF355453);

  static const Color primaryGreen = Color(0xFF00ADA7);
  static const Color primaryGreen_OP = Color(0xFFD9F1EE);
  static const Color secondaryBlue = Color(0xFF32325D);
  static const Color primaryBlue = Color(0xFF26264B);
  static const Color primaryGrey = Color(0xFFCBD6D6);
  static const Color grey1 = Color(0xFF8D9091);
  static const Color grey2 = Color(0xFFCCCCCC);
  static const Color grey3 = Color(0xFFf8f9fe);
  static const Color grey4 = Color(0xFFFBFBFB);
  static const Color grey5 = Color(0xFFCBD6D6);
  static const Color grey6 = Color(0xFF8CB1B1);
  static const Color grey7 = Color(0xFFC6D9D9);
  static const Color grey8 = Color(0xFF597473);

  static const Color red = Color(0xFFf5365c);
  static const Color yellow = Color.fromARGB(255, 197, 245, 54);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static hexToColor(String hexString) {
    var hexColor = hexString.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
