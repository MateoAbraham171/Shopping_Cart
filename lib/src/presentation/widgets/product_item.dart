import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/cart.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCartPressed;

  const ProductItem({
    super.key,
    required this.product,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.watch<Cart>(); 

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Hero(
                tag: product.id.toString(),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, color: Colors.red),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0), 
              child: IconButton(
                onPressed: onAddToCartPressed,
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30.0,
                ),
                tooltip: 'Añadir al carrito',
              ),
            )

          ],
        ),
      ),
    );
  }
}
