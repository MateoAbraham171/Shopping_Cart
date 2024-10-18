import 'package:flutter/material.dart';
import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/domain/repository/domain_cart.dart';

class CartNotifier with ChangeNotifier {
  final CartDomain _cartDomain = CartDomain();

  Map<Product, int> get items => _cartDomain.items;

  void addToCart(Product product) {
    _cartDomain.addToCart(product);
    notifyListeners();  // Notifica a la UI cada vez que se modifique el carrito
  }

  void removeFromCart(Product product) {
    _cartDomain.removeFromCart(product);
    notifyListeners();  // Notifica a la UI cada vez que se elimine un producto
  }

  void clearCart() {
    _cartDomain.clearCart();
    notifyListeners();  // Notifica a la UI cuando se vacía el carrito
  }

  int get totalItems => _cartDomain.totalItems;

  double get totalPrice => _cartDomain.totalPrice;
}
