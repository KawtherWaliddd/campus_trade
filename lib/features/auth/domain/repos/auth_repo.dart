import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/core/errors/failure.dart';
import 'package:flutter_application_1/features/auth/data/models/login_request_model.dart';
import 'package:flutter_application_1/features/auth/data/models/regiter_request_model.dart';
import 'package:flutter_application_1/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword(
    RegisterRequestModel registerRequestModel,
  );
  Future<Either<Failure, String>> signInWithEmailAndPassword(
    LoginRequestModel loginRequestModel,
  );
  Future<Either<Failure, UserModel>> signInWithGoogle();
  Future<Either<Failure, String>> signInWithFacebook();
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, String>> forgetPassword(String email);
}
