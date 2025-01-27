import 'package:flutter/material.dart';

import '../constant/color_styles.dart';

SliverAppBar sliverAppBar(
  BuildContext context,
  String text,
) {
  return SliverAppBar(
    title: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontSize: 16, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
      maxLines: 3,
    ),
    centerTitle: true,
    pinned: true,
    backgroundColor: ColorStyles.appBackGroundColor,
    leading: BackButton(
      color: ColorStyles.appTextColor,
    ),
  );
}
