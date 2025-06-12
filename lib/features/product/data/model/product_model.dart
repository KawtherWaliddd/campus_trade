class ProductModel {
  final String address;
  final String description;
  final String imageUrl;
  final String name;
  final String price;
  final String userId;
  final String productId;
  final String productState;

  ProductModel({
    required this.productId,
    required this.productState,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.userId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      address: map['address'] as String? ?? '',
      description: map['description'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      name: map['name'] as String? ?? '',
      price: map['price'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      productId: map['productId'] as String? ?? '',
      productState: map['productState'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'description': description,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'userId': userId,
      'productState': productState,
      'productId': productId
    };
  }
}
