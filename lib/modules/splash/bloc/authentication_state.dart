part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

final class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.isFirstAccess = false,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(bool isFirstAccess)
    : this._(
        status: AuthenticationStatus.authenticated,
        isFirstAccess: isFirstAccess,
      );

  const AuthenticationState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final bool isFirstAccess;

  @override
  List<Object> get props => [status];
}
