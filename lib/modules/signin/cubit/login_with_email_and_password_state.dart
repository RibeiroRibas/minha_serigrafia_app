part of 'login_with_email_and_password_cubit.dart';

final class LoginWithEmailAndPasswordState extends Equatable {
  const LoginWithEmailAndPasswordState() : this._();

  const LoginWithEmailAndPasswordState._({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const RequiredField.pure(),
    this.errorCode = 0,
    this.errorMessage = ''
  });

  final FormzSubmissionStatus status;
  final Email email;
  final RequiredField password;
  final int errorCode;
  final String errorMessage;

  LoginWithEmailAndPasswordState withEmail(String email) {
    return LoginWithEmailAndPasswordState._(
      email: Email.dirty(email),
      password: password,
    );
  }

  LoginWithEmailAndPasswordState withPassword(String password) {
    return LoginWithEmailAndPasswordState._(
      email: email,
      password: RequiredField.dirty(password),
    );
  }

  LoginWithEmailAndPasswordState withSubmissionInProgress() {
    return LoginWithEmailAndPasswordState._(
      email: email,
      password: password,
      status: FormzSubmissionStatus.inProgress,
    );
  }

  LoginWithEmailAndPasswordState withSubmissionSuccess({
    bool isFirstAccess = false,
  }) {
    return LoginWithEmailAndPasswordState._(
      email: email,
      password: password,
      status: FormzSubmissionStatus.success,
    );
  }

  LoginWithEmailAndPasswordState withSubmissionFailure({
    String? errorMessage,
    int? errorCode,
  }) {
    return LoginWithEmailAndPasswordState._(
      email: email,
      password: password,
      status: FormzSubmissionStatus.failure,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  bool get isValid => Formz.validate([email, password]);

  @override
  List<Object?> get props => [email, password, status, errorMessage, errorCode];
}
