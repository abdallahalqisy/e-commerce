import 'dart:async';
import 'package:ecommerce/main_layout.dart';
import 'package:ecommerce/notifcation.dart';
import 'package:ecommerce/session_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce/features/auth/constant.dart';
import 'package:ecommerce/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce/features/auth/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FcmApi().intNotifactions();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer _sessionTimer;

  @override
  void initState() {
    super.initState();
    _startSessionMonitor();
  }

  void _startSessionMonitor() {
    _sessionTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      final expired = await SessionManager.isSessionExpired();
      if (expired) {
        timer.cancel();
        SessionManager.logoutUser(context);
      }
    });
  }

  Future<Widget> _getInitialScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final loginTime = prefs.getString('loginTime');

    userToken = token;

    if (token != null && token.isNotEmpty) {
      if (loginTime == null) {
        await SessionManager.saveLoginTime();
      }
      return const MainLayout();
    } else {
      return BlocProvider(
        create: (context) => AuthCubit(),
        child: const LoginScreen(),
      );
    }
  }

  @override
  void dispose() {
    _sessionTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text('حدث خطأ ما')));
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}
