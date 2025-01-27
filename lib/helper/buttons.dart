import 'package:flutter/material.dart';

import '../constant/color_styles.dart';

class Buttons {
  static Widget buildElevatedButton(
    String text, {
    VoidCallback? onPressedCallback,
    Color? backRoundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressedCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: backRoundColor,
      ),
      child: Text(text, style: const TextStyle(color: ColorStyles.appTextColor)),
    );
  }
}
