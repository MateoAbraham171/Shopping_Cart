import 'package:product_prices/src/data/data.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<Products>.value(
          value: Products(productRepository: HttpProductRepository()),
        ),
        ChangeNotifierProvider<CartNotifier>(  // Cambia Cart por CartNotifier
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
    return Consumer(
      builder: (context, prefs, child) => MaterialApp(
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const ProductListScreen(),
        theme: ThemeData.dark(),
        title: 'Shopping Cart',
      ),
    );
  }
}
