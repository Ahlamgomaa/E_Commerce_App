
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:e_commerce_app/models/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Box<CartItem> cartBox;

  CartBloc({required this.cartBox}) : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      final items = cartBox.values.toList();
      emit(CartLoaded(items: items));
    });

    on<AddToCart>((event, emit) async {
      final currentState = state;
      if (currentState is CartLoaded) {
        final existingIndex = currentState.items.indexWhere(
          (i) => i.productId == event.item.productId,
        );
        if (existingIndex >= 0) {
          final existing = currentState.items[existingIndex];
          final updated = existing.copyWith(
            quantity: existing.quantity + event.item.quantity,
          );
          await cartBox.put(existing.key, updated);
        } else {
          await cartBox.add(event.item);
        }
        add(LoadCart());
      }
    });

    on<RemoveFromCart>((event, emit) async {
      final currentState = state;
      if (currentState is CartLoaded) {
        final index = currentState.items.indexWhere(
          (i) => i.productId == event.productId,
        );
        if (index >= 0) {
          await currentState.items[index].delete();
        }
        add(LoadCart());
      }
    });

    on<UpdateQuantity>((event, emit) async {
      final currentState = state;
      if (currentState is CartLoaded) {
        final index = currentState.items.indexWhere(
          (i) => i.productId == event.productId,
        );
        if (index >= 0) {
          final item = currentState.items[index];
          final newQty = event.quantity;
          if (newQty <= 0) {
            await item.delete();
          } else {
            await cartBox.put(item.key, item.copyWith(quantity: newQty));
          }
        }
        add(LoadCart());
      }
    });
  }
}
