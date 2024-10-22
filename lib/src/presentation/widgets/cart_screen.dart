import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_prices/src/presentation/presentation.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  bool _isHoveringEmpty = false; 
  bool _isHoveringPurchase = false; 

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: cart.totalItems == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('El carrito está vacío'),
                  const SizedBox(height: 16.0),
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHoveringEmpty = true),
                    onExit: (_) => setState(() => _isHoveringEmpty = false),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        backgroundColor: _isHoveringEmpty ? const Color.fromARGB(255, 43, 147, 231) : const Color.fromARGB(0, 37, 164, 238),
                      ),
                      onPressed: () {
                        navigator.pop(); // Navegar de vuelta a la pantalla anterior
                      },
                      child: Text('Ver Productos', style: TextStyle(
                        fontSize: 16.0,
                        color: _isHoveringEmpty ? Colors.black : Colors.white,
                      )),
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

                      return Padding(
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
                                'Precio unitario: \$${product.price.toStringAsFixed(2)}',
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
                                  'Total: \$${(product.price * quantity).toStringAsFixed(2)}',
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
