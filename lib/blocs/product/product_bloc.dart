import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/data/product_repository.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products: products, filtered: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });

    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) =>
          events.debounceTime(duration).switchMap(mapper);
    }

    on<SearchProducts>((event, emit) {
      final current = state;
      if (current is ProductLoaded) {
        final q = event.query.trim().toLowerCase();
        final filtered = current.products.where((p) {
          final inCategory =
              current.activeCategory == 'All' ||
              p.category == current.activeCategory;
          return inCategory &&
              (p.title.toLowerCase().contains(q) ||
                  p.description.toLowerCase().contains(q));
        }).toList();
        emit(current.copyWith(filtered: filtered, query: event.query));
      }
    }, transformer: debounce(const Duration(milliseconds: 350)));

    on<FilterByCategory>((event, emit) {
      final current = state;
      if (current is ProductLoaded) {
        final q = current.query.trim().toLowerCase();
        final filtered = current.products.where((p) {
          final inCategory =
              event.category == 'All' || p.category == event.category;
          return inCategory &&
              (p.title.toLowerCase().contains(q) ||
                  p.description.toLowerCase().contains(q));
        }).toList();
        emit(
          current.copyWith(filtered: filtered, activeCategory: event.category),
        );
      }
    });
  }
}
