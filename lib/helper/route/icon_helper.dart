import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/color_styles.dart';
import '../../constant/route_constants.dart';

class IconHelper {
  static Widget getSvgIcon({required String name, Color? color, double? size, bool? originalColor, BoxFit? fit}) {
    return SvgPicture.asset(
      name.contains('/') ? "${Routes.imagesRoute}/$name.svg" : "${Routes.iconsRoute}/$name.svg",
      colorFilter: originalColor == true
          ? null
          : ColorFilter.mode((color != null) ? color : ColorStyles.appBackGroundColor, BlendMode.srcIn),
      width: (size != null) ? size : 20,
      height: (size != null) ? size : 20,
      fit: fit ?? BoxFit.contain,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
    );
  }
}
