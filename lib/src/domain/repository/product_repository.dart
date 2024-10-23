import 'package:product_prices/src/domain/domain.dart';

abstract class ProductRepository {
  static const endpoint =
      'https://fakestoreapi.com/products';

  //Metodo que se implementa para obtener la lista de productos
  Future<List<Product>> getProductCurrencies();
}
