import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    price,
    category,
  ];
}
