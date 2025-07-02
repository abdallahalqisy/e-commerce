class BrandModel {
  final String name;
  final String slug;
  final String imageUrl;

  BrandModel({required this.name, required this.slug, required this.imageUrl});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      imageUrl: json['imageUrl'] is String ? json['imageUrl'] : '',
    );
  }
}
