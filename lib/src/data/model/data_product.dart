import 'package:product_prices/src/domain/domain.dart';

class DataProduct extends Product {
  DataProduct({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.images,
  });

  static DataProduct fromDynamic(dynamic map) {
    return DataProduct(
      id: int.tryParse(map['id'].toString()) ?? 0,
      title: map['title'],
      price: map['price'].toDouble(),
      description: map['description'],
      category: map['category'],
      image: map['image'],
      images: [map['image']],
    );
  }

  static List<DataProduct> fromDynamicList(dynamic list) {
    final result = <DataProduct>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(DataProduct.fromDynamic(map));
      }
    }

    return result;
  }
}
