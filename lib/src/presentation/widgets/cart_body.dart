import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_prices/generated/l10n.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:provider/provider.dart';

class CartBody extends StatefulWidget {
  const CartBody({
    required this.cart,
    required this.isHoveringEmpty,
    required this.isHoveringPurchase,
    super.key,
    required this.onEmptyHover,
    required this.onPurchaseHover,
  });

  final CartNotifier cart;
  final bool isHoveringEmpty;
  final bool isHoveringPurchase;
  final Function(bool isHover) onEmptyHover;
  final Function(bool isHover) onPurchaseHover;

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controlador de animaciones
  late Animation<double> _scaleAnimation; // Animación para escalar
  late Animation<Offset> _slideAnimation; // Animación para deslizar
  bool _isClearing = false; // Controla si se está vaciando el carrito
  bool _isPurchasing = false; // Controla si se está comprando

  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador de animaciones
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(milliseconds: 500), // Duración de las animaciones
      vsync: this, // Sincroniza con el ciclo de vida del widget
    );

    // Animación de escala
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Curva de animación
    ));

    // Animación de deslizamiento hacia la derecha
    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Curva de animación
      ),
    );
  }

  // Método para vaciar el carrito
  void _clearCart() {
    setState(() {
      _isClearing = true; // Actualiza el estado para mostrar la animación
    });

    _controller.forward(); // Inicia la animación de vaciar carrito
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Verifica si el widget está montado
        context.read<CartNotifier>().clearCart(); // Vacía el carrito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).cartCleared)),
        );
        setState(() {
          _isClearing = false; // Restablece el estado
        });
      }
    });
  }

  // Método para realizar la compra
  void _purchase() {
    setState(() {
      _isPurchasing = true; // Actualiza el estado para mostrar la animación
    });

    _controller.forward(); // Inicia la animación de compra
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Verifica si el widget está montado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).purchaseMade)),
        );
        context.read<CartNotifier>().clearCart(); // Vacía el carrito
        setState(() {
          _isPurchasing = false; // Restablece el estado
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  widget.cart.items.length, // Número de elementos en el carrito
              itemBuilder: (context, index) {
                final product = widget.cart.items.keys
                    .elementAt(index); // Obtiene el producto
                final quantity = widget
                    .cart.items[product]!; // Obtiene la cantidad del producto

                return SlideTransition(
                  position: _isPurchasing
                      ? _slideAnimation
                      : const AlwaysStoppedAnimation(Offset.zero),
                  child: ScaleTransition(
                    scale: _isClearing
                        ? _scaleAnimation
                        : const AlwaysStoppedAnimation(1.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: ProductImage(
                          height: 100.0,
                          width: 100.0,
                          tag: product.id.toString(),
                          url: product
                              .images[0], // Muestra la imagen del producto
                        ),
                        title: Text(
                          product.title,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S.of(context).productDescription} ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(product.price)}', // Muestra la descripción y precio del producto
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Cantidad: $quantity', // Muestra la cantidad del producto
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 200.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(product.price * quantity)}', // Muestra el total por producto
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons
                                        .remove_circle), // Botón para eliminar un producto
                                    onPressed: () {
                                      widget.cart.removeFromCart(product);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons
                                        .add_circle), // Botón para agregar un producto
                                    onPressed: () {
                                      widget.cart.addToCart(product);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).total(NumberFormat.simpleCurrency(
                          locale: Localizations.localeOf(context).toString())
                      .format(widget
                          .cart.totalPrice)), // Muestra el total del carrito
                  style: const TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MouseRegion(
                      onEnter: (_) => widget.onEmptyHover(
                          true), // Efecto hover en el botón de vaciar carrito
                      onExit: (_) => widget
                          .onEmptyHover(false), // Restablece el efecto hover
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          backgroundColor: widget.isHoveringEmpty
                              ? Colors.red
                              : const Color.fromARGB(0, 33, 149, 243),
                        ),
                        onPressed:
                            _clearCart, // Llama a la función para vaciar el carrito
                        child: Text(S.of(context).clearCart,
                            style: const TextStyle(fontSize: 16.0)),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    MouseRegion(
                      onEnter: (_) => widget.onPurchaseHover(
                          true), // Efecto hover en el botón de compra
                      onExit: (_) => widget
                          .onPurchaseHover(false), // Restablece el efecto hover
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          backgroundColor: widget.isHoveringPurchase
                              ? Colors.green
                              : const Color.fromARGB(0, 33, 149, 243),
                        ),
                        onPressed: _purchase, // Llama a la función para comprar
                        child: Text(S.of(context).purchase,
                            style: const TextStyle(fontSize: 16.0)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
