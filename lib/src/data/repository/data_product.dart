import '../../domain/model/product.dart';

class DataProduct {
  static Product fromDynamic(dynamic map) {
    return Product(
      id: int.tryParse(map['id'].toString()) ?? 0,
      title: map['title'],
      price: map['price'].toDouble(),
      description: map['description'],
      category: map['category'],
      image: map['image'],
      images: [map['image']],
    );
  }

  static List<Product> fromDynamicList(dynamic list) {
    final result = <Product>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(DataProduct.fromDynamic(map));
      }
    }

    return result;
  }
}
