import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/features/auth/data/models/regiter_request_model.dart';
import 'package:flutter_application_1/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/exception.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepo;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignupCubit(this.authRepo) : super(SignupInitial());

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String mobileNumber,
    File? imageFile,
    required String university,
    required String faculty,
  }) async {
    emit(SignupLoading());
    String? imageUrl;

    imageUrl = imageFile != null ? await uploadProfileImage(imageFile) : '';
    log('Image URL: $imageUrl');

    RegisterRequestModel registerRequestModel = RegisterRequestModel(
      firstName: firstName,
      lastName: lastName,
      phone: mobileNumber,
      email: email,
      password: password,
      confirmPassword: password,
      university: university,
      faculty: faculty,
      image: imageUrl,
    );

    final result = await authRepo.createUserWithEmailAndPassword(
      registerRequestModel,
    );

    result.fold((failure) => emit(SignupFailure(message: failure.message)), (
      userModel,
    ) {
      _createUserInFirestore(userModel);
      emit(SignupSuccess());
    });
  }

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      String fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      log('Generated file name: $fileName');

      Reference ref = FirebaseStorage.instance.ref().child(
        'profile_images/$fileName',
      );
      log('Reference to storage path created');

      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      log('Image uploaded successfully');

      String downloadUrl = await snapshot.ref.getDownloadURL();
      log('Download URL retrieved: $downloadUrl');

      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e');
      throw CustomException(message: 'Failed to upload image');
    }
  }

  Future<void> _createUserInFirestore(userModel) async {
    // It's a good practice to separate Firestore logic into a repository.
    await _firestore
        .collection('users')
        .doc(userModel.uId)
        .set(userModel.toJson())
        .then((value) {
          log('User created successfully in Firestore');
        });
  }
}
