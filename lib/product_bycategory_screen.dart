import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce/features/home/core/cubit/product_cubit.dart';
import 'package:ecommerce/features/home/core/models/product_model.dart';
import 'package:ecommerce/features/home/product_screen.dart';
import 'package:ecommerce/wishList/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBycategoryScreen extends StatelessWidget {
  final String categoryName;

  const ProductBycategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080020),
      appBar: AppBar(
        title: Text(categoryName, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (state is ProductLoaded) {
            final List<Data> products = state.products;

            if (products.isEmpty) {
              return const Center(
                child: Text(
                  'لا يوجد منتجات في هذا التصنيف',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1c1c3c),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.imageCoverUrl.toString(),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      product.title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${product.price} EGP',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        if (product.brand?.name != null)
                          Text(
                            'العلامة: ${product.brand!.name!}',
                            style: const TextStyle(color: Colors.white38),
                          ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (_) => CartCubit()),
                              BlocProvider(create: (_) => FavoriteCubit()),
                            ],
                            child: ProductDetailScreen(
                              productId: product.id ?? '',
                              price: product.price.toString(),
                              images: product.imagesUrl?.cast<String>(),
                              brand: product.brand?.name,
                              category: product.category?.name,
                              description: product.description,
                              titile: product.title,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox(); // في حالة لا يوجد state معروف
        },
      ),
    );
  }
}
