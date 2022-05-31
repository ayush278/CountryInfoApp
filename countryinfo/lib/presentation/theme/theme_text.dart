import 'package:flutter/material.dart';

extension CustomText on TextTheme {
  TextStyle get headingTextStyle => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
      );
  TextStyle get flagTextStyle => const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodyTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
}
