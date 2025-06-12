part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  ForgetPasswordSuccess({required this.message});
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String message;
  ForgetPasswordFailure({required this.message});
}
