part of 'create_access_cubit.dart';

final class CreateAccessState extends Equatable {
  const CreateAccessState() : this._();

  const CreateAccessState._({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.userName = const RequiredField.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.errorCode = 0,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final RequiredField userName;
  final Password password;
  final Password confirmPassword;
  final int errorCode;

  const CreateAccessState.initial() : this._();

  CreateAccessState withUserName(String userName) {
    return CreateAccessState._(
      userName: RequiredField.dirty(userName),
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  CreateAccessState withEmail(String email) {
    return CreateAccessState._(
      email: Email.dirty(email),
      userName: userName,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  CreateAccessState withPassword(String password) {
    return CreateAccessState._(
      password: Password.dirty(password),
      userName: userName,
      email: email,
      confirmPassword: confirmPassword,
    );
  }

  CreateAccessState withConfirmPassword(String confirmPassword) {
    return CreateAccessState._(
      confirmPassword: Password.dirty(confirmPassword),
      userName: userName,
      email: email,
      password: password,
    );
  }

  CreateAccessState withSubmissionInProgress() {
    return CreateAccessState._(
      status: FormzSubmissionStatus.inProgress,
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  CreateAccessState withSubmissionSuccess() {
    return CreateAccessState._(
      status: FormzSubmissionStatus.success,
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  CreateAccessState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return CreateAccessState._(
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  CreateAccessState reset() {
    return const CreateAccessState.initial();
  }

  bool get isValid => Formz.validate([userName,email,password,confirmPassword]) && !isPasswordNotEqual;

  bool get isPasswordNotEqual =>
      password.value.length > 5 &&
      confirmPassword.value.length > 5 &&
      password.value != confirmPassword.value;

  @override
  List<Object> get props => [
    status,
    email,
    userName,
    errorCode,
    password,
    confirmPassword,
  ];
}
