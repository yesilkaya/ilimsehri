import 'package:flutter/material.dart';

import '../../../constant/constants.dart';
import '../../constant/color_styles.dart';
import '../network_image_with_loader.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.press,
  });

  final String image, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorStyles.appTextColor),
        padding: const EdgeInsets.all(6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      clipBehavior: Clip.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildImage(),
          buildTitle(context),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Flexible(
      flex: 7,
      child: AspectRatio(
        aspectRatio: 1,
        child: LocalImageWithLoader(image, radius: defaultBorderRadious),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Flexible(
      flex: 6,
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}
