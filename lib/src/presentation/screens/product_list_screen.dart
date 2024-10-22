import 'package:product_prices/generated/l10n.dart';
import 'package:product_prices/src/domain/domain.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final Products _productListState;

  @override
  void initState() {
    super.initState();
    _productListState = context.read<Products>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListState.getProducts();
    });
  }

  @override
  void dispose() {
    _productListState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).ourBestProducts),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            label: Text(
              S.of(context).watchCart,
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _productListState.getProducts(),
        child: StreamBuilder<List<Product>>(
          stream: _productListState.productStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var productList = snapshot.data!;
            return _ProductListBody(productList: productList);
          },
        ),
      ),
    );
  }
}

class _ProductListBody extends StatelessWidget {
  const _ProductListBody({required this.productList});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartNotifier>();

    return ListView.separated(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];

        return ProductItem(
          product: product,
          onAddToCartPressed: () {
            cart.addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).addToCartSnackBar(product.title)),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
      separatorBuilder: (_, __) => const Divider(
        endIndent: 16.0,
        height: 1.0,
        indent: 16.0,
        thickness: 1.0,
      ),
    );
  }
}
