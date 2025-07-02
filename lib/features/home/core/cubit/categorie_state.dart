import 'package:ecommerce/features/home/core/models/categorie_model.dart';

abstract class CategorieState {}

class CategorieInitial extends CategorieState {}

class CategorieLoading extends CategorieState {}

class CategorieLoaded extends CategorieState {
  final List<Categories> categories;

  CategorieLoaded({required this.categories});
}

class CategorieError extends CategorieState {
  final String message;

  CategorieError({required this.message});
}
