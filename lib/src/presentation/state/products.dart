import 'dart:async';
import 'package:product_prices/generated/l10n.dart';
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
  List<Product> _productCache = []; 

  Stream<List<Product>> get productStream => _productStreamController.stream;

  void getProducts() async {
    try {
      final products = await _productRepository.getProductCurrencies();
      _productCache = products; 
      _productStreamController.add(products);
    } catch (error) {
      _logger.severe('Error fetching products: $error');
      _productStreamController.addError(error);
    }
  }

  Product? findProductById(String id) {
    try {
      final numericId = int.parse(id);
      return _productCache.firstWhere((product) => product.id == numericId);
    } catch (e) {
      _logger.warning(S.current.productNotFoundWarning(id));
      return null;
    }
  }

  @override
  void dispose() {
    _productStreamController.close();
  }
}
