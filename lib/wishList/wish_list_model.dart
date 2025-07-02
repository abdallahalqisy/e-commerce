class FavoriteData {
  final List<FavoriteItem> items;

  FavoriteData({required this.items});

  factory FavoriteData.fromJson(List<dynamic> json) {
    return FavoriteData(
      items: json.map((e) => FavoriteItem.fromJson(e)).toList(),
    );
  }
}

class FavoriteItem {
  final String id;
  final Product product;
  final String addedAt;

  FavoriteItem({
    required this.id,
    required this.product,
    required this.addedAt,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      addedAt: json['addedAt'],
    );
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final double price;
  final String imageCoverUrl;
  final List<String> imagesUrl;
  final double ratingsAverage;
  final int ratingsQuantity;
  final Category category;
  final SubCategory subCategory;
  final Brand brand;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCoverUrl,
    required this.imagesUrl,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.category,
    required this.subCategory,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      imageCoverUrl: json['imageCoverUrl'],
      imagesUrl: List<String>.from(json['imagesUrl']),
      ratingsAverage: (json['ratingsAverage'] as num).toDouble(),
      ratingsQuantity: json['ratingsQuantity'],
      category: Category.fromJson(json['category']),
      subCategory: SubCategory.fromJson(json['subCategory']),
      brand: Brand.fromJson(json['brand']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      imageUrl: json['imageUrl'],
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String slug;
  final String categoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.categoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      categoryId: json['categoryId'],
    );
  }
}

class Brand {
  final String id;
  final String name;
  final String slug;
  final String imageUrl;

  Brand({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      imageUrl: json['imageUrl'],
    );
  }
}
