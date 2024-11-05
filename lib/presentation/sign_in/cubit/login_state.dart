part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoadingLogin extends LoginState {}

final class LoginSuccess extends LoginState {
  final String userName;

  LoginSuccess(this.userName);
}

final class LoginError extends LoginState {
  final String mess;

  LoginError(this.mess);
}
