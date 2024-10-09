import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/cart.dart';
import 'package:product_prices/src/domain/domain.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile) _buildProductImage(screenSize, isMobile),
              if (!isMobile) 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildProductInfo(theme, context)),
                    SizedBox(width: screenSize.width * 0.4, child: _buildProductImage(screenSize, isMobile)),
                  ],
                )
              else
                _buildProductInfo(theme, context),
            ],
          ),
        ),
      ),
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
          product.images[0],
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error, color: Colors.red),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
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
            '\$${product.price.toStringAsFixed(2)}',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Category: ${product.category}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 47, 91, 134),
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Description',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            product.description,
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
                context.read<Cart>().addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} añadido al carrito'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Añadir al carrito'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(0, 25, 118, 210),
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
