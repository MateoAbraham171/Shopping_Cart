import 'package:product_prices/src/domain/domain.dart';

class CartDomain {
  final Map<Product, int> _items = {};

  Map<Product, int> get items => _items;

  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
  }

  void removeFromCart(Product product) {
    if (_items.containsKey(product)) {
      if (_items[product] == 1) {
        _items.remove(product);
      } else {
        _items[product] = _items[product]! - 1;
      }
    }
  }

  void clearCart() {
    _items.clear();
  }

  int get totalItems => _items.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice => _items.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);
}
