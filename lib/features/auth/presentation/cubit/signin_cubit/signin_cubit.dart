import 'package:flutter_application_1/features/auth/data/models/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repos/auth_repo.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;

  Future<void> signin(LoginRequestModel loginRequestModel) async {
    emit(SigninLoading());
    var result = await authRepo.signInWithEmailAndPassword(loginRequestModel);
    result.fold((failure) => emit(SigninFailure(message: failure.message)), (
      id,
    ) {
      // save id to shared preferences
      emit(SigninSuccess());
    });
  }

  Future<void> signinWithGoogle() async {
    emit(SigninLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (id) => emit(SigninSuccess()),
    );
  }

  Future<void> signinWithFacebook() async {
    emit(SigninLoading());
    var result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(SigninSuccess()),
    );
  }
}
