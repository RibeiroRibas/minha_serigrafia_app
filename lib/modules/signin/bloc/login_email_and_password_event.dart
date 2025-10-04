part of 'login_with_email_and_password_bloc.dart';

sealed class LoginWithEmailAndPasswordEvent extends Equatable {
  const LoginWithEmailAndPasswordEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginWithEmailAndPasswordEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChanged extends LoginWithEmailAndPasswordEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginWithEmailAndPasswordSubmitted extends LoginWithEmailAndPasswordEvent {
  const LoginWithEmailAndPasswordSubmitted();
}
