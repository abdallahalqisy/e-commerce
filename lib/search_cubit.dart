// lib/features/home/core/cubit/search_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/home/core/models/product_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchResult extends SearchState {
  final List<Data> results;

  SearchResult(this.results);
}

class SearchCubit extends Cubit<SearchState> {
  final List<Data> allProducts;

  SearchCubit(this.allProducts) : super(SearchInitial());

  void filter(String query) {
    if (query.isEmpty) {
      emit(SearchResult(allProducts));
    } else {
      final filtered = allProducts.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        return title.contains(query.toLowerCase());
      }).toList();
      emit(SearchResult(filtered));
    }
  }
}
