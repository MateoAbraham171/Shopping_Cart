import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/cart.dart';
import 'package:product_prices/src/presentation/presentation.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isHoveringEmpty = false; 
  bool _isHoveringPurchase = false; 

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: cart.totalItems == 0
          ? const Center(child: Text('El carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final product = cart.items.keys.elementAt(index);
                      final quantity = cart.items[product]!;

                      return ListTile(
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
                        subtitle: Text(
                          'Cantidad: $quantity',
                          style: const TextStyle(fontSize: 16.0), 
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${(product.price * quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0, 
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: () {
                                cart.addToCart(product);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                cart.removeFromCart(product);
                              },
                            ),
                          ],
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
                        'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
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
                              onPressed: () {
                                cart.clearCart(); 
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Carrito vaciado')),
                                );
                              },
                              child: const Text('Vaciar Carrito', style: TextStyle(fontSize: 16.0)),
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
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Compra realizada')),
                                );
                                cart.clearCart();
                              },
                              child: const Text('Realizar Compra', style: TextStyle(fontSize: 16.0)),
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
