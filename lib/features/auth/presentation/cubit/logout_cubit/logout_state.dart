part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutFailure extends LogoutState {
  final String message;
  LogoutFailure(this.message);
}
