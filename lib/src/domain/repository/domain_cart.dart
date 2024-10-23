import 'package:product_prices/src/domain/domain.dart';

class CartDomain {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => _items;

  // Agrega un producto al carrito, incrementando la cantidad si ya existe.
  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
  }

  // Elimina un producto del carrito, o lo quita si la cantidad es 1.
  void removeFromCart(Product product) {
    if (_items.containsKey(product)) {
      if (_items[product] == 1) {
        _items.remove(product);
      } else {
        _items[product] = _items[product]! - 1;
      }
    }
  }

  // Limpia todos los productos del carrito.
  void clearCart() {
    _items.clear();
  }

  // Calcula el total de artículos en el carrito.
  int get totalItems => _items.values.fold(0, (sum, qty) => sum + qty);

  // Calcula el precio total de los productos en el carrito.
  double get totalPrice => _items.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);
}
