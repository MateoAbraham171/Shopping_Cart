import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:product_prices/generated/l10n.dart';

class EmptyCartBody extends StatelessWidget {
  const EmptyCartBody({
    required this.isHoveringEmpty,
    super.key,
    required this.onEmptyHover,
  });

  final bool isHoveringEmpty;
  final Function(bool isHover) onEmptyHover;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).emptyCartMessage),
            const SizedBox(height: 24.0),
            Lottie.asset(
              'assets/lottie/empty_cart.json',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const SizedBox(height: 24.0),
            MouseRegion(
              onEnter: (_) => onEmptyHover(true), // Efecto hover
              onExit: (_) => onEmptyHover(false), // Restablece el efecto hover
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  backgroundColor: isHoveringEmpty
                      ? const Color.fromARGB(255, 43, 147, 231)
                      : const Color.fromARGB(0, 37, 164, 238),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Regresa a la pantalla anterior
                },
                child: Text(
                  S.of(context).viewProducts,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isHoveringEmpty ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
