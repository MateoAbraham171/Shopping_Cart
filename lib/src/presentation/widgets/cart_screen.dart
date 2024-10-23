import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:product_prices/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  bool _isHoveringEmpty = false; 
  bool _isHoveringPurchase = false; 
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation; // Animación para deslizar
  bool _isClearing = false; // Para controlar si se está vaciando el carrito
  bool _isPurchasing = false; // Para controlar si se está comprando

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Animación de escala
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Animación de deslizamiento hacia la derecha
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _clearCart() {
    setState(() {
      _isClearing = true;
    });

    _controller.forward(); // Iniciamos la animación de vaciar carrito
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<CartNotifier>().clearCart();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).cartCleared)),
        );
        setState(() {
          _isClearing = false;
        });
      }
    });
  }

  void _purchase() {
    setState(() {
      _isPurchasing = true;
    });

    _controller.forward(); // Iniciamos la animación de compra
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).purchaseMade)),
        );
        context.read<CartNotifier>().clearCart(); // Vaciar el carrito
        setState(() {
          _isPurchasing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).cartScreenTitle),
      ),
      body: cart.totalItems == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).emptyCartMessage),
                  const SizedBox(height: 24.0),
                  Lottie.asset(
                    'assets/lottie/empty_cart.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                  const SizedBox(height: 24.0),
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHoveringEmpty = true),
                    onExit: (_) => setState(() => _isHoveringEmpty = false),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        backgroundColor: _isHoveringEmpty ? const Color.fromARGB(255, 43, 147, 231) : const Color.fromARGB(0, 37, 164, 238),
                      ),
                      onPressed: () {
                        navigator.pop(); 
                      },
                      child: Text(
                        S.of(context).viewProducts,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: _isHoveringEmpty ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items.keys.elementAt(index);
                      final quantity = cart.items[product]!;

                      return SlideTransition(
                        position: _isPurchasing ? _slideAnimation : const AlwaysStoppedAnimation(Offset.zero),
                        child: ScaleTransition(
                          scale: _isClearing ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: ProductImage(
                                height: 100.0,
                                width: 100.0,
                                tag: product.id.toString(),
                                url: product.images[0],
                              ),
                              title: Text(
                                product.title,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${S.of(context).productDescription} ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(product.price)}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    'Cantidad: $quantity',
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
                                      'Total: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(product.price * quantity)}',
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
                                          icon: const Icon(Icons.remove_circle),
                                          onPressed: () {
                                            cart.removeFromCart(product);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle),
                                          onPressed: () {
                                            cart.addToCart(product);
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
                        S.of(context).total(NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(cart.totalPrice)),
                        style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MouseRegion(
                            onEnter: (_) => setState(() => _isHoveringEmpty = true),
                            onExit: (_) => setState(() => _isHoveringEmpty = false),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                backgroundColor: _isHoveringEmpty ? Colors.red : const Color.fromARGB(0, 33, 149, 243),
                              ),
                              onPressed: _clearCart,
                              child: Text(S.of(context).clearCart, style: const TextStyle(fontSize: 16.0)),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          MouseRegion(
                            onEnter: (_) => setState(() => _isHoveringPurchase = true),
                            onExit: (_) => setState(() => _isHoveringPurchase = false),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                backgroundColor: _isHoveringPurchase ? Colors.green : const Color.fromARGB(0, 33, 149, 243),
                              ),
                              onPressed: _purchase, // Llamamos a la función para comprar
                              child: Text(S.of(context).purchase, style: const TextStyle(fontSize: 16.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
