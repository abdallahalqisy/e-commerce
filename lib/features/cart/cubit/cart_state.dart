import 'package:ecommerce/features/cart/model/item_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartState {}

/// 🟢 الحالة الابتدائية
class CartInitial extends CartState {}

/// ⏳ أثناء تحميل بيانات السلة
class CartLoading extends CartState {}

/// ✅ تم تحميل بيانات السلة بنجاح
class CartLoadSuccess extends CartState {
  final CartData cartData;

  CartLoadSuccess({required this.cartData});
}

/// ❌ فشل تحميل بيانات السلة
class CartLoadError extends CartState {
  final String message;

  CartLoadError({required this.message});
}

/// ⏳ أثناء تنفيذ إضافة للسلة
class CartAdding extends CartState {}

/// ✅ تم إضافة عنصر للسلة بنجاح
class CartAddSuccess extends CartState {
  final String message;

  CartAddSuccess({required this.message});
}

/// ❌ فشل إضافة عنصر للسلة
class CartAddError extends CartState {
  final String message;

  CartAddError({required this.message});
}

class CartDeleteSuccess extends CartState {
  final String message;

  CartDeleteSuccess({required this.message});
}

/// ❌ فشل حذف عنصر من السلة
class CartDeleteError extends CartState {
  final String message;

  CartDeleteError({required this.message});
}

class CartClearError extends CartState {
  final String message;

  CartClearError({required this.message});
}
