part of 'login_with_email_and_password_bloc.dart';

final class LoginWithEmailAndPasswordState extends Equatable {
  const LoginWithEmailAndPasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.errorCode = 0,
    this.errorMessage = '',
  });

  final FormzSubmissionStatus status;
  final Email username;
  final Password password;
  final bool isValid;
  final int errorCode;
  final String errorMessage;

  LoginWithEmailAndPasswordState copyWith({
    FormzSubmissionStatus? status,
    Email? username,
    Password? password,
    bool? isValid,
    int? errorCode,
    String? errorMessage,
  }) {
    return LoginWithEmailAndPasswordState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
    status,
    username,
    password,
    isValid,
    errorCode,
    errorMessage,
  ];
}
