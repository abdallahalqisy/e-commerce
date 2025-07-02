import 'package:dio/dio.dart';
import 'package:ecommerce/features/auth/constant.dart';
import 'package:ecommerce/features/home/core/models/categorie_model.dart';
import 'package:ecommerce/features/home/core/cubit/categorie_state.dart'
    as state;
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorieCubit extends Cubit<state.CategorieState> {
  CategorieCubit() : super(state.CategorieInitial());
  final Dio dio = Dio();

  Future<void> fetchCategories() async {
    emit(state.CategorieLoading());
    try {
      final response = await dio.get('$baseUrl/api/Categories');
      if (response.statusCode == 200) {
        final data = response.data as List;
        final categories = data
            .map((item) => Categories.fromJson(item))
            .toList();
        emit(state.CategorieLoaded(categories: categories));
      } else {
        emit(state.CategorieError(message: 'Failed to load categories'));
      }
    } on DioException catch (e) {
      emit(state.CategorieError(message: e.message ?? 'An error occurred'));
    }
  }
}
