import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/features/SellScreen/Data/model/Sell_Product_Model.dart';

class SellProductRepo {
  Future<Either<Failure, SellProductModel>> uploadProductData(
    SellProductModel sellProductModel,
  ) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection("products");
      final docRef = await collectionRef.add({
        "productState": sellProductModel.productState,
        "name": sellProductModel.productName,
        "description": sellProductModel.description,
        "price": sellProductModel.price,
        "address": sellProductModel.address,
        "imageUrl": sellProductModel.imageUrl,
        "userId": sellProductModel.userId,
      });
      await collectionRef.doc(docRef.id).update({"productId": docRef.id});

      // Create a new instance with the updated productId
      final updatedProduct = SellProductModel(
        productId: docRef.id,
        productState: sellProductModel.productState,
        productName: sellProductModel.productName,
        description: sellProductModel.description,
        price: sellProductModel.price,
        address: sellProductModel.address,
        imageUrl: sellProductModel.imageUrl,
        userId: sellProductModel.userId,
      );

      return right(updatedProduct);
    } catch (e) {
      return left(ServerFailure("Error uploading product data: $e"));
    }
  }
}
