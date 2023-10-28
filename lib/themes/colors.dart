import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();
  static final instance = CustomColors._();

  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color grey = Color(0xffA1AEB1);
  static const Color darkGreyColor = Color(0xff768791);
  static const Color menthol = Color(0xffC6EAA7);
  static const Color spiroDiscoBall = Color(0xff29C9E7);
  static const Color lavender = Color(0xffC9C1D5);
  static const Color spaceCadet = Color(0xff233251);
  static const Color yankeesBlue = Color(0xff192942);
  static const Color transparent = Colors.transparent;
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
