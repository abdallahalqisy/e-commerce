class Product {
  int? results;
  Metadata? metadata;
  List<Data>? data;

  Product({this.results, this.metadata, this.data});

  Product.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Metadata {
  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  Metadata({this.currentPage, this.numberOfPages, this.limit, this.nextPage});

  Metadata.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
    nextPage = json['nextPage'];
  }
}

class Data {
  String? id;
  String? title;
  String? slug;
  String? description;
  num? quantity;
  num? price;
  String? imageCoverUrl;
  List<String>? imagesUrl;
  num? sold;
  double? ratingsAverage;
  num? ratingsQuantity;
  String? createdAt;
  String? updatedAt;
  Category? category;
  SubCategory? subCategory;
  Category? brand;

  Data({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCoverUrl,
    this.imagesUrl,
    this.sold,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategory,
    this.brand,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    imageCoverUrl = json['imageCoverUrl'];
    imagesUrl = List<String>.from(json['imagesUrl'] ?? []);
    sold = json['sold'];
    ratingsAverage = (json['ratingsAverage'] as num?)?.toDouble();
    ratingsQuantity = json['ratingsQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? SubCategory.fromJson(json['subCategory'])
        : null;
    brand = json['brand'] != null ? Category.fromJson(json['brand']) : null;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class SubCategory {
  String? id;
  String? name;
  String? slug;
  String? categoryId;
  String? createdAt;
  String? updatedAt;

  SubCategory({
    this.id,
    this.name,
    this.slug,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    categoryId = json['categoryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
