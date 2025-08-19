import 'package:e_commerce_app/ViewModel/cart/cart_bloc.dart';
import 'package:e_commerce_app/custom_widget/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return ListTile(
                          leading: Image.network(
                            item.imageUrl,
                            width: 70,
                            height: 66,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => context.read<CartBloc>().add(
                                  UpdateQuantity(
                                    productId: item.productId,
                                    quantity: item.quantity - 1,
                                  ),
                                ),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => context.read<CartBloc>().add(
                                  UpdateQuantity(
                                    productId: item.productId,
                                    quantity: item.quantity + 1,
                                  ),
                                ),
                              ),
                              IconButtonApp(
                                icon: Icon(Icons.delete_outline),
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                    RemoveFromCart(productId: item.productId),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
