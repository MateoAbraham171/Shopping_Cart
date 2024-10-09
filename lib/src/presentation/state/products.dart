import 'dart:async';
import 'package:product_prices/src/domain/domain.dart';
import 'package:logging/logging.dart';

abstract class Disposable {
  void dispose();
}

class Products implements Disposable {
  Products({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final _logger = Logger('ProductListState');
  final ProductRepository _productRepository;

  final _productStreamController = StreamController<List<Product>>.broadcast();

  Stream<List<Product>> get productStream => _productStreamController.stream;

  void getProducts() async {
    try {
      final products = await _productRepository.getProductCurrencies();
      _productStreamController.add(products);
    } catch (error) {
      _logger.severe('Error fetching products: $error');
      _productStreamController.addError(error);
    }
  }

  @override
  void dispose() {
    _productStreamController.close();
  }
}
