// favorite_state.dart

import 'package:ecommerce/wishList/wish_list_model.dart';

sealed class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final FavoriteData favoriteData;

  FavoriteLoaded({required this.favoriteData});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError({required this.message});
}

class FavoriteAddSuccess extends FavoriteState {
  final String message;

  FavoriteAddSuccess({required this.message});
}

class FavoriteAddError extends FavoriteState {
  final String message;

  FavoriteAddError({required this.message});
}

class FavoriteRemoveSuccess extends FavoriteState {
  final String message;

  FavoriteRemoveSuccess({required this.message});
}

class FavoriteRemoveError extends FavoriteState {
  final String message;

  FavoriteRemoveError({required this.message});
}
