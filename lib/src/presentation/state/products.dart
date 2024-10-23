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

  final _logger = Logger('ProductListState'); // Logger para registrar eventos.
  final ProductRepository _productRepository; // Repositorio para obtener productos.

  // Controlador de flujo para emitir una lista de productos.
  final _productStreamController = StreamController<List<Product>>.broadcast();
  List<Product> _productCache = []; // Caché para almacenar productos.

  // Stream que expone la lista de productos.
  Stream<List<Product>> get productStream => _productStreamController.stream;

  // Método para obtener productos del repositorio.
  void getProducts() async {
    try {
      // Llama al repositorio para obtener productos.
      final products = await _productRepository.getProductCurrencies();
      _productCache = products; // Almacena los productos en caché.
      _productStreamController.add(products); // Emite la lista de productos.
    } catch (error) {
      _logger.severe('Error fetching products: $error'); // Registra errores.
      _productStreamController.addError(error); // Emite error en el stream.
    }
  }

  // Busca un producto por su ID.
  Product? findProductById(String id) {
    try {
      final numericId = int.parse(id); 
      return _productCache.firstWhere((product) => product.id == numericId); // Busca el producto en caché.
    } catch (e) {
      _logger.warning(S.current.productNotFoundWarning(id)); // Registra advertencia si no se encuentra el producto.
      return null; // Devuelve null si no se encuentra.
    }
  }

  @override
  void dispose() {
    _productStreamController.close(); // Libera recursos cerrando el controlador de flujo.
  }
}
