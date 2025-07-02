// ✅ CartCubit بعد التعديلات النهائية لتحديث الحالة تلقائيًا بعد حذف عنصر
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/auth/constant.dart';
import 'package:ecommerce/features/cart/cubit/cart_state.dart';
import 'package:ecommerce/features/cart/model/item_cart_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final Dio dio = Dio();

  List<CartItem> _items = [];
  double _totalPrice = 0;

  Future<dynamic> addToCart(String productId) async {
    emit(CartLoading());

    try {
      final response = await dio.post(
        'http://freshcartapi.runasp.net/api/Cart',
        data: {'productId': productId, 'quantity': 1},
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        log('✅ Product added to cart: $responseData');
        emit(CartAddSuccess(message: 'تمت الإضافة بنجاح'));
        return responseData;
      } else {
        emit(CartAddError(message: 'فشل الإضافة: ${response.statusCode}'));
        return 'Error ${response.statusCode}';
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data ?? 'خطأ في الاتصال بالسيرفر';
      emit(CartAddError(message: errorMessage));
      return errorMessage;
    } catch (e) {
      emit(CartAddError(message: 'حدث خطأ غير متوقع'));
      return 'Unexpected error';
    }
  }

  Future<void> getCartItems() async {
    emit(CartLoading());

    try {
      final response = await dio.get(
        'http://freshcartapi.runasp.net/api/Cart',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData == null) {
          emit(CartLoadError(message: 'لا توجد بيانات في السلة'));
          return;
        }

        final cartData = CartData.fromJson(jsonData);

        // ✅ تخزين العناصر داخليًا
        _items = cartData.items;
        _totalPrice = cartData.totalCartPrice;

        emit(CartLoadSuccess(cartData: cartData));
      } else {
        emit(CartLoadError(message: 'فشل التحميل: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      emit(CartLoadError(message: e.message ?? 'خطأ في الاتصال'));
    } catch (e) {
      emit(CartLoadError(message: e.toString() ?? 'حدث خطأ غير متوقع'));
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      final response = await dio.delete(
        'http://freshcartapi.runasp.net/api/Cart/$cartItemId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('✅ Item deleted from cart: $cartItemId');

        // ✅ تحديث القائمة بعد الحذف
        _items.removeWhere((item) => item.id == cartItemId);
        _totalPrice = _items.fold(0.0, (sum, item) => sum + item.totalPrice);

        emit(
          CartLoadSuccess(
            cartData: CartData(
              items: _items,
              totalCartPrice: _totalPrice,
              id: '',
            ),
          ),
        );
      } else {
        emit(CartDeleteError(message: 'فشل الحذف: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data.toString() ?? 'خطأ في الاتصال بالسيرفر';
      emit(CartDeleteError(message: errorMessage));
    } catch (e) {
      emit(CartDeleteError(message: 'حدث خطأ غير متوقع'));
    }
  }
}
