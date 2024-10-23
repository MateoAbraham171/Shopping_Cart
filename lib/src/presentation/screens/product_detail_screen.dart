import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/presentation/state/presentation_cart.dart';
import 'package:product_prices/generated/l10n.dart'; 
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title)),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: isMobile
                ? _buildMobileLayout(theme, context, screenSize)
                : _buildDesktopLayout(theme, context, screenSize),
          ),
          if (_isAnimating) // Muestra la animación al agregar al carrito.
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/add_to_cart_animation.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(ThemeData theme, BuildContext context, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(screenSize, true),
        _buildProductInfo(theme, context),
      ],
    );
  }

  Widget _buildDesktopLayout(ThemeData theme, BuildContext context, Size screenSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildProductInfo(theme, context)),
        SizedBox(width: screenSize.width * 0.05),
        _buildProductImage(screenSize, false),
      ],
    );
  }

  Widget _buildProductImage(Size screenSize, bool isMobile) {
    final imageSize = isMobile ? screenSize.width - 32 : screenSize.width * 0.4;
    return Container(
      width: imageSize,
      height: imageSize,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          widget.product.images.isNotEmpty ? widget.product.images[0] : '',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error, color: Colors.red),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // Muestra el child si no hay progreso de carga.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildProductInfo(ThemeData theme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(widget.product.price),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            S.of(context).categoryLabel(widget.product.category),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 47, 91, 134),
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            S.of(context).productDescription,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.product.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16.0,
              height: 1.5,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isAnimating = true; // Inicia la animación.
                });

                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    _isAnimating = false; // Detiene la animación después de 2 segundos.
                  });
                });

                context.read<CartNotifier>().addToCart(widget.product); // Agrega el producto al carrito.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).addToCartSnackBar(widget.product.title)),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text(S.of(context).addToCart),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
