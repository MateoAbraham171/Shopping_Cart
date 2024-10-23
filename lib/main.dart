import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:product_prices/src/data/data.dart';
import 'package:product_prices/src/presentation/presentation.dart';
import 'package:product_prices/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que el binding de widgets esté inicializado

  runApp(
    MultiProvider(
      providers: [
        // Proveedor para gestionar productos
        Provider<Products>(
          create: (context) => Products(
            productRepository: HttpProductRepository(), // Crea una instancia de Products con un repositorio HTTP
          )..getProducts(), // Llama a getProducts() para cargar los productos
          dispose: (_, products) => products.dispose(), // Libera recursos cuando el proveedor se elimina
        ),
        // Proveedor para gestionar el carrito de compras
        ChangeNotifierProvider<CartNotifier>(
          create: (_) => CartNotifier(), // Crea una instancia de CartNotifier
        ),
      ],
      child: const ProductPricesApp(), // Inicia la aplicación
    ),
  );
}

class ProductPricesApp extends StatelessWidget {
  const ProductPricesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = _createRouter(context); // Crea el enrutador

    return MaterialApp.router(
      routerConfig: router, // Configura el enrutador
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración
      darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      title: 'Shopping Cart',
      localizationsDelegates: const [
        S.delegate, // Delegado de localización generado
        GlobalMaterialLocalizations.delegate, // Delegado para las localizaciones de Material
        GlobalWidgetsLocalizations.delegate, // Delegado para las localizaciones de Widgets
        GlobalCupertinoLocalizations.delegate, // Delegado para las localizaciones de Cupertino
      ],
      supportedLocales: const [
        Locale('en', ''), // Soporta el idioma inglés
        Locale('es', ''), // Soporta el idioma español
      ],
    );
  }

  GoRouter _createRouter(BuildContext context) {
    // Crea el enrutador usando GoRouter
    return GoRouter(
      routes: [
        GoRoute(
          path: '/', // Ruta principal
          name: 'productList',
          builder: (context, state) => const ProductListScreen(), // Pantalla de lista de productos
          routes: [
            GoRoute(
              path: 'product/:id', // Ruta para los detalles del producto
              name: 'productDetail', // Nombre de la ruta de detalles del producto
              builder: (context, state) {
                final productId = state.pathParameters['id']!; // Obtiene el ID del producto de los parámetros de la ruta
                final products = Provider.of<Products>(context, listen: false); // Obtiene la instancia de Products sin escuchar cambios
                final product = products.findProductById(productId); // Busca el producto por ID

                if (product == null) {
                  return ProductNotFoundScreen(productId: productId); // Si no se encuentra el producto, muestra una pantalla de error
                }

                return ProductDetailScreen(product: product); // Muestra la pantalla de detalles del producto
              },
            ),
            GoRoute(
              path: 'cart', // Ruta para la pantalla del carrito
              name: 'cart', // Nombre de la ruta del carrito
              builder: (context, state) => const CartScreen(), // Pantalla del carrito
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const ProductNotFoundScreen(
        productId: 'unknown', // Pantalla de error para productos no encontrados
      ),
      debugLogDiagnostics: true, // Habilita el registro de diagnósticos para depuración
    );
  }
}
