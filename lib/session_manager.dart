import 'dart:developer';

import 'package:ecommerce/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _loginTimeKey = 'loginTime';

  static Future<void> saveLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loginTimeKey, DateTime.now().toIso8601String());
  }

  static Future<bool> isSessionExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final loginTimeStr = prefs.getString(_loginTimeKey);

    if (loginTimeStr == null) return false;

    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) return false;

    final now = DateTime.now();
    final diff = now.difference(loginTime).inMinutes;

    log('⌛ Session age: $diff minutes');
    return diff >= 1000;
  }

  static Future<void> logoutUser(BuildContext context) async {
    log('🚪 Session expired. Logging out...');
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Future.microtask(() {
      if (context.mounted) {
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
    });
  }
}
