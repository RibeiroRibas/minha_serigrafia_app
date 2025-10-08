part of 'login_with_google_cubit.dart';

final class LoginWithGoogleState extends Equatable {
  const LoginWithGoogleState() : this._();

  const LoginWithGoogleState._({
    this.status = FormzSubmissionStatus.initial,
    this.errorCode = 0,
    this.isFirstAccess = false,
  });

  final FormzSubmissionStatus status;
  final int errorCode;
  final bool isFirstAccess;

  LoginWithGoogleState withSubmissionInProgress() {
    return LoginWithGoogleState._(status: FormzSubmissionStatus.inProgress);
  }

  LoginWithGoogleState withSubmissionSuccess({bool isFirstAccess = false}) {
    return LoginWithGoogleState._(
      status: FormzSubmissionStatus.success,
      isFirstAccess: isFirstAccess,
    );
  }

  LoginWithGoogleState withSubmissionFailure({
    String? errorMessage,
    int? errorCode,
  }) {
    return LoginWithGoogleState._(
      status: FormzSubmissionStatus.failure,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props => [status, errorCode, isFirstAccess];
}
