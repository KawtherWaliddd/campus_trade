import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repos/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepo) : super(ForgetPasswordInitial());

  final AuthRepo authRepo;

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());

    final result = await authRepo.forgetPassword(email);

    result.fold(
      (failure) => emit(ForgetPasswordFailure(message: failure.message)),
      (message) => emit(ForgetPasswordSuccess(message: message)),
    );
  }
}
