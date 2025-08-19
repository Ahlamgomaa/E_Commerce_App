import 'package:e_commerce_app/ViewModel/cart/cart_bloc.dart';
import 'package:e_commerce_app/models/cart_item_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Product Detail",
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.imageUrl,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 17),
              Text(product.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 17),
              Text(product.description),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to Cart'),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

