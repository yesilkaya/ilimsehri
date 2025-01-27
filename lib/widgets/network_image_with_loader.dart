import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/constants.dart';
import 'place_holder.dart';

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = defaultPadding,
  });

  final String src;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) =>
            Container(decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: fit))),
        placeholder: (context, url) => const LoadingCardAnimation(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class LocalImageWithLoader extends StatelessWidget {
  const LocalImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.fill,
    this.radius = 80.0,
    this.widget,
  });

  final String src;
  final double radius;
  final BoxFit fit;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: widget ??
          (src.contains('.svg')
              ? SvgPicture.asset(
                  src,
                  fit: fit,
                )
              : Image.asset(
                  src,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                )),
    );
  }
}
