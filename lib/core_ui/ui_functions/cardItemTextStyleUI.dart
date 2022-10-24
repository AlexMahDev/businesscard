import 'package:flutter/material.dart';
import '../themes/text_theme.dart';

class CardItemTextStyleUI {
  TextStyle getTextStyle(final String label) {
    if (label == "fullName") {
      return TextThemeCustom.fullNameTextTheme;
    } else if (label == "headline") {
      return TextThemeCustom.headlineTextTheme;
    } else {
      return const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    }
  }
}
