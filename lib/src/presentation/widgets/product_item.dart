import 'package:product_prices/generated/l10n.dart';
import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatelessWidget {
  final Product product; // Almacena el producto
  final VoidCallback onAddToCartPressed; // Callback para la acción de añadir al carrito

  // Constructor que recibe el producto y la función para añadir al carrito
  const ProductItem({
    super.key,
    required this.product,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtiene el tema actual
    context.watch<CartNotifier>(); // Escucha los cambios en el CartNotifier

    return GestureDetector(
      // Permite detectar gestos en el widget
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navega a la pantalla de detalles del producto al hacer tap
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
                // Widget Hero para la transición de animación
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
                      product.images[0], // Carga la imagen del producto desde la URL
                      fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
                      errorBuilder: (context, error, stackTrace) {
                        // Muestra un contenedor con un icono de error si falla la carga
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
                    overflow: TextOverflow.ellipsis, // El texto se cortará con puntos suspensivos si es demasiado largo
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(product.price), // Formatea el precio del producto
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: onAddToCartPressed, // Llama a la función para añadir al carrito
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30.0,
                ),
                tooltip: S.of(context).addToCart, // Mensaje de ayuda para el icono
              ),
            ),
          ],
        ),
      ),
    );
  }
}
