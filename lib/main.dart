import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:product_prices/src/data/data.dart';
import 'package:product_prices/src/presentation/presentation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<Products>(
          create: (context) => Products(
            productRepository: HttpProductRepository(),
          )..getProducts(),
          dispose: (_, products) => products.dispose(),
        ),
        ChangeNotifierProvider<CartNotifier>(
          create: (_) => CartNotifier(),
        ),
      ],
      child: const ProductPricesApp(),
    ),
  );
}

class ProductPricesApp extends StatelessWidget {
  const ProductPricesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = _createRouter(context);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      title: 'Shopping Cart',
    );
  }

  GoRouter _createRouter(BuildContext context) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'productList',
          builder: (context, state) => const ProductListScreen(),
          routes: [
            GoRoute(
              path: 'product/:id',
              name: 'productDetail',
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                final products = Provider.of<Products>(context, listen: false);
                final product = products.findProductById(productId);

                if (product == null) {
                  return ProductNotFoundScreen(productId: productId);
                }

                return ProductDetailScreen(product: product);
              },
            ),
            GoRoute(
              path: 'cart',
              name: 'cart',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const ProductNotFoundScreen(
        productId: 'unknown',
      ),
      debugLogDiagnostics: true,
    );
  }
}
