import 'package:flutter_application_1/features/product/data/model/product_model.dart';

abstract class ProductRepository {
  Stream<List<ProductModel>> getProductsByUser(String userId);
  Future<void> updateProductState(String productId, String state);
}
