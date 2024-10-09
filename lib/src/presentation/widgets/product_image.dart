import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.height,
    super.key,
    required this.url,
    required this.tag,
    required this.width,
  });

  final double height;
  final double width;
  final String tag;
  final String url;

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: ColoredBox(
            color: Colors.white,
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: height,
              imageUrl: url,
              placeholder: (context, url) => const CircularProgressIndicator(),
              width: width,
            ),
          ),
        ),
      );
}
