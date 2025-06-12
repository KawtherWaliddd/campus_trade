import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/core/errors/exception.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/core/services/firebase_auth_services.dart';
import 'package:flutter_application_1/features/auth/data/models/user_model.dart';
import 'package:flutter_application_1/features/auth/domain/repos/auth_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/login_request_model.dart';
import '../models/regiter_request_model.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  AuthRepoImpl({required this.firebaseAuthServices});

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
    RegisterRequestModel registerRequestModel,
  ) async {
    try {
      late String? imageUrl;
      if (registerRequestModel.image != null &&
          registerRequestModel.image is File) {
        final imageFile = registerRequestModel.image as File;
        imageUrl = await _uploadImageToStorage(imageFile);
      } else if (registerRequestModel.image is String) {
        imageUrl = registerRequestModel.image as String;
      }

      var user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: registerRequestModel.email,
        password: registerRequestModel.password,
      );

      UserModel userModel = UserModel(
        firstName: registerRequestModel.firstName,
        lastName: registerRequestModel.lastName,
        mobileNumber: registerRequestModel.phone,
        email: registerRequestModel.email,
        image:
            imageUrl ??
            '', //   image: imageUrl!, user isn't added to data base due to null exception
        university: registerRequestModel.university,
        faculty: registerRequestModel.faculty,
        uId: user.uid,
        createdAt: Timestamp.now(),
      );

      await firestore.collection('users').doc(user.uid).set(userModel.toMap());

      return right(userModel);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('An error occurred. Please try again later.'));
    }
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';

      Reference ref = FirebaseStorage.instance.ref().child(
        'profile_images/$fileName',
      );
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw CustomException(message: 'Failed to upload image');
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
    LoginRequestModel loginRequestModel,
  ) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: loginRequestModel.email,
        password: loginRequestModel.password,
      );
      return right(user.uid);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('Something went wrong please try again later'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      var userCredential = await firebaseAuthServices.signInWithGoogle();
      final user = userCredential.user;

      if (user == null) {
        return left(ServerFailure("User is null"));
      }

      final userDoc = await firestore.collection('users').doc(user.uid).get();

      UserModel userModel;

      if (!userDoc.exists) {
        userModel = UserModel(
          firstName: user.displayName?.split(' ').first ?? 'No Name',
          lastName: user.displayName?.split(' ').last ?? '',
          mobileNumber: user.phoneNumber ?? '',
          email: user.email ?? '',
          image: user.photoURL ?? '',
          university: '',
          faculty: '',
          uId: user.uid,
          createdAt: Timestamp.now(),
        );

        await firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());
      } else {
        // إذا كان مستخدم موجود، استرجع بياناته
        userModel = UserModel.fromMap(userDoc.data()!);
      }

      return right(userModel);
    } catch (e) {
      print('Exception in google auth ${e.toString()}');
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithFacebook() async {
    try {
      var userCredential = await firebaseAuthServices.signInWithFacebook();
      final uid = userCredential.user?.uid;
      if (uid != null) {
        return right(uid);
      } else {
        return left(ServerFailure("User UID is null"));
      }
    } catch (e) {
      print('Exception in facebook auth ${e.toString()}');
    }
    return left(ServerFailure("try again"));
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    try {
      await firebaseAuthServices.sendPasswordResetEmail(email);
      return const Right("Reset email sent successfully");
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final isGoogleUser =
          user?.providerData.any((info) => info.providerId == 'google.com') ??
          false;
      await FirebaseAuth.instance.signOut();
      if (isGoogleUser) {
        await GoogleSignIn().signOut();
      }

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Logout failed'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error during logout'));
    }
  }
}
