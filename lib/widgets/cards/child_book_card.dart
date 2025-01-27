import 'package:flutter/material.dart';

import '../../../constant/constants.dart';
import '../../constant/color_styles.dart';

class ChildBookCard extends StatelessWidget {
  const ChildBookCard({
    super.key,
    required this.image,
    this.brandName,
    required this.title,
    this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    this.press,
    this.style,
    required this.index,
  });
  final String image, title;
  final String? brandName;
  final double? price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  final VoidCallback? press;
  final int index;

  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: style ??
          OutlinedButton.styleFrom(
            side: const BorderSide(color: ColorStyles.appTextColor),
            minimumSize: const Size(150, 140),
            maximumSize: const Size(150, 140),
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 5,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultBorderRadious),
                      child: Image.asset(
                        (image.contains('masumlar') || image.contains('peygamberler'))
                            ? image + '${index + 1}.jpeg'
                            : image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (dicountpercent != null)
                    Positioned(
                      right: defaultPadding / 2,
                      bottom: defaultPadding / 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                        height: 16,
                        decoration: const BoxDecoration(
                          color: errorColor,
                          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadious)),
                        ),
                        child: Text(
                          "$dicountpercent% indirim",
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 3),
                  Text(
                    brandName != null ? brandName!.toUpperCase() : "",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10),
                    maxLines: 1,
                  ),
                  SizedBox(height: 3),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 3),
                  priceAfetDiscount != null
                      ? Row(
                          children: [
                            Text(
                              "\₺$priceAfetDiscount",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "\₺$price",
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium!.color,
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 3),
                            ),
                          ],
                        )
                      : Text(
                          "\₺$price",
                          style: const TextStyle(
                            color: Color(0xFF31B0D8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
