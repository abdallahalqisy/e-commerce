import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/auth/constant.dart';
import 'package:ecommerce/features/auth/cubit/auth_state.dart';
import 'package:ecommerce/session_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial());
  final Dio dio = Dio();
  // sign Up

  Future<dynamic> signUp(
    String name,
    String email,
    String phone,
    String password,
    String passwordConfirmation,
  ) async {
    emit(SignUpLoadingState());
    final data = {
      'name': name,
      'email': email,
      'phoneNumber': phone,
      'password': password,
      'rePassword': passwordConfirmation,
    };
    try {
      data['email'] = email;
      data['name'] = name;
      data['phoneNumber'] = phone;
      data['password'] = password;
      data['rePassword'] = passwordConfirmation;

      final response = await dio.post('$baseUrl/api/Auth/register', data: data);

      if (response.statusCode == 200) {
        // Check if response data contains expected fields
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          log('SignUp successful: ${responseData['message']}');
          emit(SignUpSuccessStat());

          // Log for debugging

          return responseData;
        } else {
          log('Invalid response format: ${response.data}');
          return "Invalid response format from server";
        }
      } else {
        log('HTTP Error: ${response.statusCode}');
        return "Login failed with status code: ${response.statusCode}";
      }
    } on DioException catch (e) {
      log('Dio Login error: ${e.message}');
      if (e.response != null) {
        log('Response status: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');

        // Check for specific error messages from API
        if (e.response?.data != null &&
            e.response?.data is Map<String, dynamic> &&
            e.response?.data['message'] != null) {
          emit(FailedToSignUpState(message: e.response?.data['message']));
          return e.response?.data['message'];
        }
      }
      return "The email or password you entered is incorrect, try again.";
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    emit(LoginLoadingState());

    final data = {'email': email, 'password': password};

    try {
      data['email'] = email;
      data['password'] = password;

      final response = await dio.post('$baseUrl/api/Auth/login', data: data);

      if (response.statusCode == 200) {
        emit(LoginSuccessState());

        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          userToken = responseData['token']?.toString() ?? '';
          final prefs = await SharedPreferences.getInstance();

          prefs.setString('token', userToken!);

          // ✅ حفظ وقت الدخول
          await SessionManager.saveLoginTime();

          log('Login successful: $userToken');
          return responseData;
        } else {
          log('Invalid response format: ${response.data}');
          return "Invalid response format from server";
        }
      } else {
        log('HTTP Error: ${response.statusCode}');
        return "Login failed with status code: ${response.statusCode}";
      }
    } on DioException catch (e) {
      log('Dio Login error: ${e.message}');
      if (e.response != null) {
        log('Response status: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');

        // Check for specific error messages from API
        if (e.response?.data != null &&
            e.response?.data is Map<String, dynamic> &&
            e.response?.data['message'] != null) {
          emit(
            FailedToLoginState(
              message: 'The password is incorrect. Please try again.',
            ),
          );
          return e.response?.data['message'];
        }
      }
      return "The email or password you entered is incorrect, try again.";
    }
  }
}
