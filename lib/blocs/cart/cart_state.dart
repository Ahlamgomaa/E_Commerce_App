part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  const CartLoaded({required this.items});

  double get totalPrice =>
      items.fold(0.0, (sum, i) => sum + i.price * i.quantity);

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;
  const CartError({required this.message});
  @override
  List<Object?> get props => [message];
}
