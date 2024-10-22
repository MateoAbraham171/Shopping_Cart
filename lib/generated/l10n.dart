// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Category: {category}`
  String categoryLabel(String category) {
    return Intl.message(
      'Category: $category',
      name: 'categoryLabel',
      desc: 'Label that displays the product category',
      args: [category],
    );
  }

  /// `Description: `
  String get productDescription {
    return Intl.message(
      'Description: ',
      name: 'productDescription',
      desc: 'Label for the product description',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: 'Button text to add a product to the cart',
      args: [],
    );
  }

  /// `View cart`
  String get watchCart {
    return Intl.message(
      'View cart',
      name: 'watchCart',
      desc: 'Button text to view the cart',
      args: [],
    );
  }

  /// `Our best products`
  String get ourBestProducts {
    return Intl.message(
      'Our best products',
      name: 'ourBestProducts',
      desc: 'Title of the product_list_screen page',
      args: [],
    );
  }

  /// `{product} added to the cart`
  String addToCartSnackBar(String product) {
    return Intl.message(
      '$product added to the cart',
      name: 'addToCartSnackBar',
      desc: 'Label that shows when a product is added to the cart',
      args: [product],
    );
  }

  /// `We could not find the product {productId}.`
  String productNotFound(String productId) {
    return Intl.message(
      'We could not find the product $productId.',
      name: 'productNotFound',
      desc: 'Label displayed when a product is not found',
      args: [productId],
    );
  }

  /// `Shopping Cart`
  String get cartScreenTitle {
    return Intl.message(
      'Shopping Cart',
      name: 'cartScreenTitle',
      desc: 'Title of the cart screen',
      args: [],
    );
  }

  /// `The cart is empty`
  String get emptyCartMessage {
    return Intl.message(
      'The cart is empty',
      name: 'emptyCartMessage',
      desc: 'Message displayed when the cart is empty',
      args: [],
    );
  }

  /// `View Products`
  String get viewProducts {
    return Intl.message(
      'View Products',
      name: 'viewProducts',
      desc: 'Button text to navigate back to products',
      args: [],
    );
  }

  /// `Total: ${totalPrice}`
  String total(double totalPrice) {
    return Intl.message(
      'Total: \$$totalPrice',
      name: 'total',
      desc: 'Label for the total price in the cart',
      args: [totalPrice],
    );
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message(
      'Clear Cart',
      name: 'clearCart',
      desc: 'Button text to clear the cart',
      args: [],
    );
  }

  /// `Make Purchase`
  String get purchase {
    return Intl.message(
      'Make Purchase',
      name: 'purchase',
      desc: 'Button text to make a purchase',
      args: [],
    );
  }

  /// `Cart cleared`
  String get cartCleared {
    return Intl.message(
      'Cart cleared',
      name: 'cartCleared',
      desc: 'Message displayed when the cart is cleared',
      args: [],
    );
  }

  /// `Purchase made`
  String get purchaseMade {
    return Intl.message(
      'Purchase made',
      name: 'purchaseMade',
      desc: 'Message displayed when a purchase is completed',
      args: [],
    );
  }

  /// `Product with ID {productId} not found or invalid ID format`
  String productNotFoundWarning(String productId) {
    return Intl.message(
      'Product with ID $productId not found or invalid ID format',
      name: 'productNotFoundWarning',
      desc:
          'Warning message when a product is not found or the ID format is invalid',
      args: [productId],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
