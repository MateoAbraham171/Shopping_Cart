import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:product_prices/src/data/data.dart';
import 'package:product_prices/src/domain/domain.dart';

class HttpProductRepository implements ProductRepository {
  final _logger = Logger('HttpProductRepository');
  static const String _endpoint = 'https://fakestoreapi.com/products';

  /// Método para obtener la lista de productos desde la API.
  @override
  Future<List<Product>> getProductCurrencies() async {
    final uri = Uri.parse(_endpoint);
    _logger.finest('--- HTTP REQUEST ---\nURL: $_endpoint');
    final response = await http.get(uri);

    _logger.finest(
      '--- HTTP response ---\nStatus Code: ${response.statusCode}\nResponse Body: ${response.body}',
    );

    if (response.statusCode == HttpStatus.ok) {
      final productList = DataProduct.fromDynamicList(
        json.decode(response.body),
      );
      return productList;
    } else {
      throw Exception('Failed to load product data');
    }
  }
}
