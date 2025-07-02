import 'package:ecommerce/features/home/core/models/product_model.dart';
import 'package:flutter/material.dart';

class CustomItemtoGrideView extends StatelessWidget {
  final Data product;

  const CustomItemtoGrideView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 158,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.imageCoverUrl ?? '',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Column(
          children: [
            Text(
              product.title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              '${product.price ?? 0} EGP',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
