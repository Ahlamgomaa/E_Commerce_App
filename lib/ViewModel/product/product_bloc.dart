import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/data/product_servicesdart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductServices service;

  ProductBloc({required this.service}) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await service.fetchProducts();
        emit(ProductLoaded(products: products, filtered: products));
      } catch (e) {
        String errorMessage = 'An error occurred while loading products.';
        if (e.toString().contains('No internet connection')) {
          errorMessage =
              'No internet connection. Please check your network and try again.';
        } else if (e.toString().contains('timeout')) {
          errorMessage =
              'Request timeout. Please check your connection and try again.';
        } else if (e.toString().contains('Failed host lookup')) {
          errorMessage =
              'Unable to reach the server. Please check your internet connection.';
        }
        emit(ProductError(message: errorMessage));
      }
    });


    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) =>
          events.debounceTime(duration).switchMap(mapper);//control
    }

    on<SearchProducts>((event, emit) {
      final current = state;
      if (current is ProductLoaded) {
        final q = event.query.trim().toLowerCase();//sensitive 
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
    }, transformer: debounce(const Duration(milliseconds: 350))); //best performance 

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
