class SellProductModel {
  final String productName;
  final String description;
  final String price;
  final String imageUrl;
  final String address;
  final String productId;
  final String productState;
  final String userId;

  SellProductModel({
    required this.productName,
    required this.description,
    required this.productState,
    required this.price,
    required this.imageUrl,
    required this.address,
    required this.productId,
    required this.userId,
  });

  factory SellProductModel.fromMap(Map<String, dynamic> map) {
    return SellProductModel(
      productState: map['productState'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      description: map['description'] as String? ?? '',
      price: map['price'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      address: map['address'] as String? ?? '',
      productId: map['productId'] as String? ?? '', // هنا صححناها
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'address': address,
      'productId': productId, // هنا برضو صححناها
      'userId': userId,
      'productState': productState,
    };
  }
}
