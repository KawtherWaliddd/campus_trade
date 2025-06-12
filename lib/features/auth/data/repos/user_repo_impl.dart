import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Either<Failure, UserModel>> getUserById(String uid) async {
    try {
      //  final uid = FirebaseAuth.instance.currentUser?.uid;
      print("Fetching user with UID: $uid");

      final docSnapshot = await firestore
          .collection('users')
          .where('uId', isEqualTo: uid)
          .get();
      if (docSnapshot.docs.isNotEmpty) {
        final userModel = UserModel.fromMap(docSnapshot.docs.first.data());
        return right(userModel);
      } else {
        return left(ServerFailure("User not found!!"));
      }
    } catch (e) {
      return left(
          ServerFailure("An error occurred while fetching the user data: $e"));
    }
  }
}
