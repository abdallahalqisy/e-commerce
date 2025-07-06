import 'package:ecommerce/core/util/stripe_servece.dart';
import 'package:ecommerce/features/brand/brand_screen.dart';
import 'package:ecommerce/features/brand/cubit/brand_cubit.dart';
import 'package:ecommerce/features/cart/cart_screen.dart';
import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce/features/home/home_screen.dart';
import 'package:ecommerce/features/payment/paymentcubit/payment_cubit.dart';
import 'package:ecommerce/features/payment/repos/checkout_repo.dart';
import 'package:ecommerce/features/payment/repos/checkout_repo_impl.dart';
import 'package:ecommerce/features/profile/cubit/addres_cubit.dart';
import 'package:ecommerce/features/profile/profile_screen.dart';
import 'package:ecommerce/wishList/cubit/wishlist_cubit.dart';
import 'package:ecommerce/wishList/fav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      // 🏠 الصفحة الرئيسية
      const HomeScreen(),

      // 🛒 صفحة السلة
      BlocProvider(
        create: (_) => CartCubit()..getCartItems(),
        child: BlocProvider(
          create: (_) => PaymentCubit(CheckoutRepoImpl(StripeService())),
          child: const CartScreen(),
        ),
      ),
      BlocProvider(
        create: (context) => FavoriteCubit()..fetchFavorites(),
        child: FavoriteScreen(),
      ),
      BlocProvider(
        create: (context) => BrandCubit()..getBrands(),
        child: BrandScreen(),
      ),

      // 👤 صفحة الحساب
      BlocProvider(
        create: (context) => AddressCubit()..fetchAddresses(),
        child: ProfileScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080020),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff080020),
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,

        // 🛠️ هذا السطر هو المهم عند وجود 4 أو أكثر عناصر
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'السلة',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'البرندات',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}
