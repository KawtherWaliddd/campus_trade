import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../model/product_model.dart';

class PresentDataRepo {
  final FirebaseFirestore firestore;

  PresentDataRepo({required this.firestore});

  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final querySnapshot = await firestore.collection('products').get();

      if (querySnapshot.docs.isNotEmpty) {
        final products = querySnapshot.docs
            .map((doc) => ProductModel.fromMap(doc.data()))
            .toList();
        return right(products);
      } else {
        return left(ServerFailure("No products found!"));
      }
    } on FirebaseException catch (e) {
      return left(ServerFailure("Firestore error: ${e.message}"));
    } catch (e) {
      return left(
          ServerFailure("An unexpected error occurred: ${e.toString()}"));
    }
  }

  Future<Either<Failure, String>> getUserNameById(String userId) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(userId).get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        final firstName = userData?['firstName'] ?? '';
        final lastName = userData?['lastName'] ?? '';
        return right('$firstName $lastName'.trim());
      }
      return left(ServerFailure("User not found"));
    } on FirebaseException catch (e) {
      return left(ServerFailure("Firestore error: ${e.message}"));
    } catch (e) {
      return left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }
}
