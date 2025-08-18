part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filtered;
  final String activeCategory;
  final String query;
  const ProductLoaded({
    required this.products,
    required this.filtered,
    this.activeCategory = 'All',
    this.query = '',
  });

  @override
  List<Object?> get props => [products, filtered, activeCategory, query];

  ProductLoaded copyWith({
    List<Product>? products,
    List<Product>? filtered,
    String? activeCategory,
    String? query,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      filtered: filtered ?? this.filtered,
      activeCategory: activeCategory ?? this.activeCategory,
      query: query ?? this.query,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
