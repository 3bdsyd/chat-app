import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    hexColor = hexColor.length == 6 ? 'FF$hexColor' : '';
    return int.parse(hexColor, radix: 16);
  }
}
