import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/user_repo_impl.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  final String uid;

  UserCubit(this.userRepository, this.uid) : super(UserInitial());

  Future<void> fetchUserData() async {
    emit(UserLoading());
    try {
      if (uid.isEmpty) {
        emit(UserError("User ID is required"));
        return;
      }

      print("User ID: $uid");

      final result = await userRepository.getUserById(uid);
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (user) => emit(UserLoaded(user)),
      );
    } catch (e) {
      emit(UserError("Error fetching user: ${e.toString()}"));
    }
  }
}
