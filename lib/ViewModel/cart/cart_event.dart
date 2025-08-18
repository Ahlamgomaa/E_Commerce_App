part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;
  const AddToCart({required this.item});
  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final int productId;
  const RemoveFromCart({required this.productId});
  @override
  List<Object?> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final int productId;
  final int quantity;
  const UpdateQuantity({required this.productId, required this.quantity});
  @override
  List<Object?> get props => [productId, quantity];
}

