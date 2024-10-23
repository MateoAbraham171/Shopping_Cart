import 'package:flutter/material.dart';
import 'package:product_prices/generated/l10n.dart';

class ProductNotFoundScreen extends StatelessWidget {
  final String productId; // Identificador del producto que no se encontró.

  const ProductNotFoundScreen({
    super.key,
    required this.productId, // Requiere el ID del producto como parámetro.
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            S.of(context).productNotFound(productId),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
