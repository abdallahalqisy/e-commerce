import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/brand/brand_model.dart';
import 'package:ecommerce/features/brand/cubit/brand_stata.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit() : super(BrandInitial());

  final Dio dio = Dio();

  Future<void> getBrands() async {
    emit(BrandLoading());
    try {
      final response = await dio.get(
        'http://freshcartapi.runasp.net/api/Brands',
      );

      final List data = response.data; // ← لأن response بيرجع List مش Map
      final brands = data.map((e) => BrandModel.fromJson(e)).toList();

      emit(BrandSuccess(brands));
    } catch (e) {
      emit(BrandError('حدث خطأ: ${e.toString()}'));
    }
  }
}
