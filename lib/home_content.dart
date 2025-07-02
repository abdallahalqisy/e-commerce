import 'package:ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce/features/home/core/cubit/categorie_cubit.dart';
import 'package:ecommerce/features/home/core/models/product_model.dart';
import 'package:ecommerce/features/home/product_screen.dart';
import 'package:ecommerce/features/home/widgets/banners.dart';
import 'package:ecommerce/features/home/widgets/custom_list_view.dart';
import 'package:ecommerce/features/home/widgets/gride_view_prodect_item.dart';
import 'package:ecommerce/features/home/widgets/search_field.dart';
import 'package:ecommerce/search_cubit.dart';
import 'package:ecommerce/wishList/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  final List<Data> products;
  final TextEditingController controller = TextEditingController();

  HomeContent({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SearchField(
            controller: controller,
            onChanged: (query) {
              context.read<SearchCubit>().filter(query);
            },
          ),
          const SizedBox(height: 20),
          HomeBannerSlider(),
          const SizedBox(height: 20),

          BlocProvider(
            create: (context) => CategorieCubit()..fetchCategories(),
            child: const CustomListView(),
          ),
          const SizedBox(height: 20),

          const Text(
            'Latest',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              List<Data> filtered = products;

              if (state is SearchResult) {
                filtered = state.results;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                ),
                itemBuilder: (context, index) {
                  final product = filtered[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<CartCubit>(),
                              ),
                              BlocProvider.value(
                                value: context.read<FavoriteCubit>(),
                              ),
                            ],
                            child: ProductDetailScreen(
                              productId: product.id ?? '',
                              price: product.price.toString(),
                              images: product.imagesUrl,
                              brand: product.brand?.name,
                              category: product.category?.name,
                              description: product.description,
                              titile: product.title,
                            ),
                          ),
                        ),
                      );
                    },
                    child: CustomItemtoGrideView(product: product),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
