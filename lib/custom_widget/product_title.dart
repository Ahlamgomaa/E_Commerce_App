import 'package:e_commerce_app/ViewModel/cart/cart_bloc.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/views/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.imageUrl,
        width: 70,
        height: 66,
        fit: BoxFit.cover,
      ),
      title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      trailing: IconButton(
        icon: const Icon(Icons.add_shopping_cart),
        onPressed: () {
          context.read<CartBloc>().add(
            AddToCart(
              item: CartItem(
                productId: product.id,
                title: product.title,
                imageUrl: product.imageUrl,
                price: product.price,
                quantity: 1,
              ),
            ),
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Added to cart')));
        },
      ),
    );
  }
}
