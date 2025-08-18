import 'package:e_commerce_app/ViewModel/product/product_bloc.dart';
import 'package:e_commerce_app/custom_widget/product_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/theme.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6_outlined),
              onPressed: () => context.read<ThemeApp>().toggleTheme(),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            if (state is ProductLoaded) {
              final categories = [
                'All',
                ...{for (final p in state.products) p.category},
              ];
              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<ProductBloc>().add(LoadProducts()),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => context.read<ProductBloc>().add(
                          SearchProducts(value),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 44,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          final isActive = state.activeCategory == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isActive,
                            onSelected: (_) => context.read<ProductBloc>().add(
                              FilterByCategory(cat),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemCount: categories.length,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.filtered.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final product = state.filtered[index];
                          return ProductTile(product: product);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

