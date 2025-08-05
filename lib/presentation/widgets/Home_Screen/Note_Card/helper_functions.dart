import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  static bool isDarkColor(Color color) {
    double brightness =
        (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness < 128;
  }

  static String getFormattedDate(DateTime date) {
    return DateFormat.yMMMd('en_US').add_jm().format(date);
  }

  static Color getDarkerColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    final darkerHsl = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }
}
