class Categories {
  String? id;
  String? name;
  String? slug;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Categories({
    this.id,
    this.name,
    this.slug,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
