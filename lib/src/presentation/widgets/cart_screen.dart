import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:product_prices/generated/l10n.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  bool _isHoveringEmpty =
      false; // Controla el efecto hover en el botón de vaciar carrito
  bool _isHoveringPurchase =
      false; // Controla el efecto hover en el botón de compra

  void _onEmptyHover(bool isHover) =>
      setState(() => _isHoveringEmpty = isHover);
  void _onPurchaseHover(bool isHover) =>
      setState(() => _isHoveringPurchase = isHover);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>(); // Obtiene el estado del carrito

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).cartScreenTitle),
      ),
      body: cart.totalItems == 0 // Comprueba si el carrito está vacío
          ? EmptyCartBody(
              isHoveringEmpty: _isHoveringEmpty,
              onEmptyHover: _onEmptyHover,
            )
          : CartBody(
              cart: cart,
              isHoveringEmpty: _isHoveringEmpty,
              isHoveringPurchase: _isHoveringPurchase,
              onEmptyHover: _onEmptyHover,
              onPurchaseHover: _onPurchaseHover,
            ),
    );
  }
}
