import 'package:ecommerce/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce/features/auth/cubit/logout.dart';
import 'package:ecommerce/features/auth/screens/login_screen.dart';
import 'package:ecommerce/features/cart/cart_screen.dart';
import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          logoutUser(
            context, // تمرير السياق هنا
          ).then((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => AuthCubit(),
                  child: const LoginScreen(),
                ),
              ),
            );
          });
        },
        child: Image.asset('assets/image/appbar_logo.png', height: 20),
      ),

      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CartCubit()
                    ..getCartItems()
                    ..deleteCartItem(''),
                  child: const CartScreen(),
                ),
              ),
            );
            // هنا ممكن تضيف كود لفتح سلة التسوق
          },
        ),
      ],
      backgroundColor: Color(0xff080020).withOpacity(1),
    );
  }
}
