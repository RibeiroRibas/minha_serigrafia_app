part of 'user_access_cubit.dart';

final class UserAccessState extends Equatable {
  const UserAccessState() : this._();

  const UserAccessState._({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.userName = const RequiredField.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.errorCode = 0,
    this.isEmailInUse = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final RequiredField userName;
  final Password password;
  final Password confirmPassword;
  final int errorCode;
  final bool isEmailInUse;

  const UserAccessState.initial() : this._();

  UserAccessState withUserName(String userName) {
    return UserAccessState._(
      userName: RequiredField.dirty(userName),
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  UserAccessState withEmail(String email) {
    return UserAccessState._(
      email: Email.dirty(email),
      userName: userName,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  UserAccessState withPassword(String password) {
    return UserAccessState._(
      password: Password.dirty(password),
      userName: userName,
      email: email,
      confirmPassword: confirmPassword,
    );
  }

  UserAccessState withConfirmPassword(String confirmPassword) {
    return UserAccessState._(
      confirmPassword: Password.dirty(confirmPassword),
      userName: userName,
      email: email,
      password: password,
    );
  }

  UserAccessState withSubmissionInProgress() {
    return UserAccessState._(
      status: FormzSubmissionStatus.inProgress,
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  UserAccessState withSubmissionSuccess() {
    return UserAccessState._(
      status: FormzSubmissionStatus.success,
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  UserAccessState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return UserAccessState._(
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
      isEmailInUse: isEmailInUse ?? this.isEmailInUse,
    );
  }

  UserAccessState reset() {
    return const UserAccessState.initial();
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
    isEmailInUse,
  ];
}
