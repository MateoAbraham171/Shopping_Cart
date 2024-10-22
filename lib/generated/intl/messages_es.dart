// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(product) => "${product} añadido al carrito";

  static String m1(category) => "Categoría: ${category}";

  static String m2(productId) =>
      "No pudimos encontrar el producto ${productId}.";

  static String m3(productId) =>
      "Producto con ID ${productId} no encontrado o formato de ID inválido";

  static String m4(totalPrice) => "Total: \$${totalPrice}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addToCart": MessageLookupByLibrary.simpleMessage("Añadir al carrito"),
        "addToCartSnackBar": m0,
        "cartCleared": MessageLookupByLibrary.simpleMessage("Carrito vaciado"),
        "cartScreenTitle":
            MessageLookupByLibrary.simpleMessage("Carrito de Compras"),
        "categoryLabel": m1,
        "clearCart": MessageLookupByLibrary.simpleMessage("Vaciar Carrito"),
        "emptyCartMessage":
            MessageLookupByLibrary.simpleMessage("El carrito está vacío"),
        "ourBestProducts":
            MessageLookupByLibrary.simpleMessage("Nuestros mejores productos"),
        "productDescription":
            MessageLookupByLibrary.simpleMessage("Descripción: "),
        "productNotFound": m2,
        "productNotFoundWarning": m3,
        "purchase": MessageLookupByLibrary.simpleMessage("Realizar Compra"),
        "purchaseMade":
            MessageLookupByLibrary.simpleMessage("Compra realizada"),
        "total": m4,
        "viewProducts": MessageLookupByLibrary.simpleMessage("Ver Productos"),
        "watchCart": MessageLookupByLibrary.simpleMessage("Ver carrito")
      };
}
