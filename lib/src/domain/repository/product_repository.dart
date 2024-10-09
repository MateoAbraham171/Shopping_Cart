import 'package:product_prices/src/domain/domain.dart';

abstract class ProductRepository {
  static const endpoint =
      'https://fakestoreapi.com/products';

  Future<List<Product>> getProductCurrencies();
}
