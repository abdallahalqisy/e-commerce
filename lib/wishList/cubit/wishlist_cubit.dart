import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/auth/constant.dart';
import 'package:ecommerce/wishList/cubit/wishlist_state.dart';
import 'package:ecommerce/wishList/wish_list_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  final Dio dio = Dio();
  List<FavoriteItem> _items = [];

  List<FavoriteItem> get items => _items;

  /// ✅ جلب المفضلة من السيرفر
  Future<void> fetchFavorites() async {
    emit(FavoriteLoading());
    try {
      final response = await dio.get(
        '$baseUrl/api/WishList',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final wishlistData = FavoriteData.fromJson(data);

        _items = wishlistData.items;

        emit(FavoriteLoaded(favoriteData: wishlistData));
      } else {
        emit(FavoriteError(message: 'فشل تحميل المفضلة'));
      }
    } on DioException catch (e) {
      emit(FavoriteError(message: e.message ?? 'خطأ في الاتصال'));
    } catch (e) {
      emit(FavoriteError(message: 'حدث خطأ غير متوقع'));
    }
  }

  /// ✅ Toggle المفضلة: إضافة أو إزالة حسب الحالة
  Future<void> addToFavorites(String productId) async {
    final alreadyFavorite = isFavorite(productId);

    if (alreadyFavorite) {
      await removeFromFavorites(productId);
    } else {
      try {
        final response = await dio.post(
          '$baseUrl/api/WishList',
          data: {"productId": productId},
          options: Options(
            headers: {
              'Authorization': 'Bearer $userToken',
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          log('✅ Added to favorites: ${response.data}');
          await fetchFavorites();
        } else {
          emit(FavoriteError(message: 'فشل الإضافة إلى المفضلة'));
        }
      } catch (e) {
        emit(FavoriteError(message: 'حدث خطأ أثناء الإضافة'));
      }
    }
  }

  /// ✅ إزالة من المفضلة
  Future<void> removeFromFavorites(String productId) async {
    try {
      final response = await dio.delete(
        '$baseUrl/api/WishList/$productId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('✅ Removed from favorites: $productId');
        await fetchFavorites();
      } else {
        emit(FavoriteError(message: 'فشل الحذف من المفضلة'));
      }
    } catch (e) {
      emit(FavoriteError(message: 'حدث خطأ أثناء الحذف'));
    }
  }

  /// ✅ هل المنتج موجود في المفضلة؟
  bool isFavorite(String productId) {
    return _items.any((item) => item.product.id == productId);
  }
}
