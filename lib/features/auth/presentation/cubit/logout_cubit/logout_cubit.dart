import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repos/auth_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo authRepo;
  LogoutCubit(this.authRepo) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await authRepo.logOut();
    result.fold(
      (failure) => emit(LogoutFailure(failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
