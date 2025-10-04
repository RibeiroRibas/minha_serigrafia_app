part of 'login_with_google_bloc.dart';

final class LoginWithGoogleState extends Equatable {
  const LoginWithGoogleState({
    this.status = FormzSubmissionStatus.initial,
    this.isFirstAccess = false,
  });

  final FormzSubmissionStatus status;
  final bool isFirstAccess;

  LoginWithGoogleState copyWith({
    FormzSubmissionStatus? status,
    bool? isFirstAccess,
  }) {
    return LoginWithGoogleState(
      status: status ?? this.status,
      isFirstAccess: isFirstAccess ?? this.isFirstAccess,
    );
  }

  @override
  List<Object> get props => [status];
}
