import 'package:flutter/material.dart';

import '../constant/color_styles.dart';
import '../helper/text_helper.dart';

class DefaultAppBar {
  static AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: ColorStyles.appBackGroundColor,
      titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
      title: Text(
        TextHelper.capitalizeWords(title),
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: 16, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
        maxLines: 3,
      ),
      leading: const BackButton(
        color: ColorStyles.appTextColor,
      ),
    );
  }
}
