import 'package:flutter/material.dart';

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Detecta si el tema es oscuro o claro
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return ListView.separated(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade300, // Diferentes colores según el tema
                  borderRadius: BorderRadius.circular(12), // Bordes redondeados
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDarkTheme ? Colors.grey.shade800 : Colors.grey.shade300, // Cambia según el tema
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: isDarkTheme ? Colors.grey.shade700 : Colors.grey.shade200, // Cambia según el tema
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: isDarkTheme ? Colors.grey.shade700 : Colors.grey.shade200, // Cambia según el tema
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: isDarkTheme ? Colors.grey.shade600 : Colors.grey.shade400, // Cambia el color del divider
        height: 1,
        thickness: 0.5,
      ),
    );
  }
}
