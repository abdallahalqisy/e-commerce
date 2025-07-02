import 'package:ecommerce/features/home/core/cubit/categorie_cubit.dart';
import 'package:ecommerce/features/home/core/cubit/categorie_state.dart';
import 'package:ecommerce/features/home/core/cubit/product_cubit.dart';
import 'package:ecommerce/features/home/core/models/categorie_model.dart';
import 'package:ecommerce/product_bycategory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorieCubit, CategorieState>(
      builder: (context, state) {
        if (state is CategorieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategorieError) {
          return Center(child: Text(state.message));
        } else if (state is CategorieLoaded) {
          final List<Categories> categories = state.categories;

          return SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final categoryName = category.name ?? '';

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) =>
                                    ProductCubit()
                                      ..fetchProductItem(categoryName),
                                child: ProductBycategoryScreen(
                                  categoryName: categoryName,
                                ),
                              ),
                            ),
                          );
                        },

                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              category.imageUrl ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text(
                          categoryName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
