import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/home/core/models/product_model.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final Dio dio = Dio();

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final response = await dio.get(
        'http://freshcartapi.runasp.net/api/Products?pageNumber=1&pageSize=20',
      );

      final List<dynamic> dataList = response.data['data'];
      final List<Data> products = dataList
          .map((item) => Data.fromJson(item))
          .toList();

      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> fetchProductItem(String categoryName) async {
    emit(ProductLoading());
    try {
      final response = await dio.get(
        'http://freshcartapi.runasp.net/api/Products?categoryName=$categoryName&pageNumber=1&pageSize=50',
      );

      final List<dynamic> dataList = response.data['data'];
      final List<Data> products = dataList
          .map((item) => Data.fromJson(item))
          .toList();

      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
