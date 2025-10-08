part of 'sign_up_bloc.dart';

final class SignUpState extends Equatable {
  const SignUpState() : this._();

  const SignUpState._({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.userName = const RequiredField.pure(),
    this.companyName = const RequiredField.pure(),
    this.cellPhone = const Cellphone.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.errorCode = 0,
    this.isEmailInUse = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final RequiredField userName;
  final RequiredField companyName;
  final Cellphone cellPhone;
  final Password password;
  final Password confirmPassword;
  final int errorCode;
  final bool isEmailInUse;

  SignUpState withUserName(String userName) {
    return SignUpState._(
      userName: RequiredField.dirty(userName),
      companyName: companyName,
      cellPhone: cellPhone,
    );
  }

  SignUpState withEmail(String email) {
    return SignUpState._(
      email: Email.dirty(email),
      userName: userName,
      cellPhone: cellPhone,
      companyName: companyName,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  SignUpState withCompanyName(String companyName) {
    return SignUpState._(
      companyName: RequiredField.dirty(companyName),
      userName: userName,
      cellPhone: cellPhone,
    );
  }

  SignUpState withCellPhone(String cellPhone) {
    return SignUpState._(
      cellPhone: Cellphone.dirty(cellPhone),
      userName: userName,
      companyName: companyName,
    );
  }

  SignUpState withPassword(String password) {
    return SignUpState._(
      password: Password.dirty(password),
      userName: userName,
      cellPhone: cellPhone,
      companyName: companyName,
      email: email,
      confirmPassword: confirmPassword,
    );
  }

  SignUpState withConfirmPassword(String confirmPassword) {
    return SignUpState._(
      confirmPassword: Password.dirty(confirmPassword),
      userName: userName,
      cellPhone: cellPhone,
      companyName: companyName,
      email: email,
      password: password,
    );
  }

  SignUpState withSubmissionInProgress() {
    return SignUpState._(
      status: FormzSubmissionStatus.inProgress,
      userName: userName,
      cellPhone: cellPhone,
      companyName: companyName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  SignUpState withSubmissionSuccess() {
    return SignUpState._(
      status: FormzSubmissionStatus.success,
      userName: userName,
      cellPhone: cellPhone,
      companyName: companyName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  SignUpState withSubmissionFailure({int? errorCode, bool? isEmailInUse}) {
    return SignUpState._(
      userName: userName,
      cellPhone: cellPhone,
      companyName: companyName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
      isEmailInUse: isEmailInUse ?? this.isEmailInUse,
    );
  }

  bool get isStepOneValid =>
      Formz.validate([userName, companyName, cellPhone]) && !isPasswordNotEqual;

  bool get isStepTwoValid => Formz.validate([
    email,
    password,
    confirmPassword,
    userName,
    companyName,
    cellPhone,
  ]);

  bool get isCompleteSignUpValid => Formz.validate([companyName, cellPhone]);

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
    companyName,
    cellPhone,
    password,
    confirmPassword,
    isEmailInUse,
  ];
}
