import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce/features/home/core/cubit/product_cubit.dart';

import 'package:ecommerce/features/home/widgets/custom_app_%20bar.dart';

import 'package:ecommerce/features/home/widgets/shimmar.dart';
import 'package:ecommerce/home_content.dart';
import 'package:ecommerce/search_cubit.dart';
import 'package:ecommerce/wishList/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()..fetchProducts()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => FavoriteCubit()),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: const Color(0xff080020),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, productState) {
            if (productState is ProductLoading) {
              return const CustomShimmer();
            } else if (productState is ProductError) {
              return Center(
                child: Text(
                  productState.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (productState is ProductLoaded) {
              final allProducts = productState.products;

              return BlocProvider(
                create: (_) => SearchCubit(allProducts),
                child: HomeContent(products: allProducts),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
