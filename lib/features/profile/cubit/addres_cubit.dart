// address_cubit.dart

import 'package:dio/dio.dart';
import 'package:ecommerce/features/profile/cubit/addres_state.dart';
import 'package:ecommerce/features/profile/models/addres_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/features/auth/constant.dart'; // لو عندك baseUrl هنا

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final Dio dio = Dio();

  Future<void> fetchAddresses() async {
    emit(AddressLoading());

    try {
      final response = await dio.get(
        '$baseUrl/api/Addresses',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
        ),
      ); // عدل الرابط حسب API الحقيقي

      if (response.statusCode == 200) {
        final data = response.data as List;
        final addresses = data
            .map((item) => AddressModel.fromJson(item))
            .toList();
        emit(AddressLoaded(addresses: addresses));
      } else {
        emit(AddressError(message: 'فشل في تحميل العناوين'));
      }
    } on DioException catch (e) {
      emit(AddressError(message: e.message ?? 'خطأ في الاتصال'));
    }
  }
}
