import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce/features/auth/screens/login_screen.dart';

Future<void> logoutUser(BuildContext context) async {
  log('🚪 Logging out...');
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // 🧹 حذف كل البيانات من التخزين المؤقت

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => AuthCubit(),
        child: const LoginScreen(),
      ),
    ),
    (route) => false,
  );
}
