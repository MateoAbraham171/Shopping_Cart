import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.height,
    super.key,
    required this.url,
    required this.tag, // Etiqueta para la animación Hero
    required this.width,
  });

  final double height;
  final double width;
  final String tag;
  final String url;

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag, // Utiliza la etiqueta Hero para transiciones de animación
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: ColoredBox(
            color: Colors.white,
            child: CachedNetworkImage(
              // Widget que carga la imagen desde una URL y la almacena en caché
              errorWidget: (context, url, error) => const Icon(Icons.error), // Widget a mostrar en caso de error
              height: height,
              imageUrl: url,
              placeholder: (context, url) => const CircularProgressIndicator(), // Widget a mostrar mientras se carga la imagen
              width: width,
            ),
          ),
        ),
      );
}
