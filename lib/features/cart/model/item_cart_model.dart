class CartItem {
  final String id;
  final String productId;
  final String productTitle;
  final double productPrice;
  final String imageCoverUrl;
  final int quantity;
  final double totalPrice;

  CartItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.imageCoverUrl,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      productPrice: (json['productPrice'] as num).toDouble(),
      imageCoverUrl: json['imageCoverUrl'],
      quantity: json['quantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}

class CartData {
  final String id;
  final List<CartItem> items;
  final double totalCartPrice;

  CartData({
    required this.id,
    required this.items,
    required this.totalCartPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['id'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalCartPrice: (json['totalCartPrice'] as num).toDouble(),
    );
  }
}
