// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(product) => "${product} added to the cart";

  static String m1(category) => "Category: ${category}";

  static String m2(productId) => "We could not find the product ${productId}.";

  static String m3(productId) =>
      "Product with ID ${productId} not found or invalid ID format";

  static String m4(totalPrice) => "Total: \$${totalPrice}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addToCart": MessageLookupByLibrary.simpleMessage("Add to cart"),
        "addToCartSnackBar": m0,
        "cartCleared": MessageLookupByLibrary.simpleMessage("Cart cleared"),
        "cartScreenTitle":
            MessageLookupByLibrary.simpleMessage("Shopping Cart"),
        "categoryLabel": m1,
        "clearCart": MessageLookupByLibrary.simpleMessage("Clear Cart"),
        "emptyCartMessage":
            MessageLookupByLibrary.simpleMessage("The cart is empty"),
        "ourBestProducts":
            MessageLookupByLibrary.simpleMessage("Our best products"),
        "productDescription":
            MessageLookupByLibrary.simpleMessage("Description: "),
        "productNotFound": m2,
        "productNotFoundWarning": m3,
        "purchase": MessageLookupByLibrary.simpleMessage("Make Purchase"),
        "purchaseMade": MessageLookupByLibrary.simpleMessage("Purchase made"),
        "total": m4,
        "viewProducts": MessageLookupByLibrary.simpleMessage("View Products"),
        "watchCart": MessageLookupByLibrary.simpleMessage("View cart")
      };
}
