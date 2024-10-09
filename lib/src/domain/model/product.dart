class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image; // Cambiado a String
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.images,
  });

  // Factory para construir un Product a partir de un mapa dinámico (JSON)
  factory Product.fromDynamic(dynamic map) {
    return Product(
      id: int.tryParse(map['id'].toString()) ?? 0, // Convertir a int
      title: map['title'],
      price: map['price'].toDouble(),
      description: map['description'],
      category: map['category'],
      image: map['image'],
      images: [map['image']], // Solo la imagen principal por ahora
    );
  }

  // Método para convertir una lista dinámica en una lista de productos
  static List<Product> fromDynamicList(dynamic list) {
    final result = <Product>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(Product.fromDynamic(map));
      }
    }

    return result;
  }
}
