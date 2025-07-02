import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce/features/cart/cubit/cart_state.dart';
import 'package:ecommerce/wishList/cubit/wishlist_cubit.dart';
import 'package:ecommerce/wishList/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String? description;
  final List<String>? images;
  final String? brand;
  final String? category;
  final String? titile;
  final String? price;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.description,
    this.images,
    this.brand,
    this.category,
    this.titile,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff080020),
      appBar: AppBar(
        backgroundColor: const Color(0xff080020),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (images != null && images!.isNotEmpty)
              CarouselSlider(
                items: images!
                    .map(
                      (image) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                ),
              )
            else
              const Center(
                child: Text(
                  'لا توجد صور',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            const SizedBox(height: 20),

            /// ✅ زر السلة والمفضلة جنب بعض
            Row(
              children: [
                /// زر السلة
                Expanded(
                  child: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is CartAddSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ تمت الإضافة إلى السلة'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is CartAddError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: state is CartLoading
                            ? null
                            : () => context.read<CartCubit>().addToCart(
                                productId,
                              ),
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        label: state is CartLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'إضافة للسلة',
                                style: TextStyle(color: Colors.white),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff080020),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                /// زر المفضلة
                Expanded(
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) {
                      final isFav = context.read<FavoriteCubit>().isFavorite(
                        productId,
                      );

                      return ElevatedButton.icon(
                        onPressed: () {
                          context.read<FavoriteCubit>().addToFavorites(
                            productId,
                          );
                        },
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        label: const Text(
                          'مفضلة',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff080020),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              '${price ?? "غير متوفر"} EGP',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'التصنيف: ${category ?? "غير معروف"}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              'العلامة التجارية: ${brand ?? "غير معروف"}',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'الوصف:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              description ?? 'لا يوجد وصف.',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
