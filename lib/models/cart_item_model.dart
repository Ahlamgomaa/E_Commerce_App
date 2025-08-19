
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class CartItem extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: productId,
      title: title,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, title, imageUrl, price, quantity];
}

