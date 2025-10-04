import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._currentAuthUserService, this._firebaseAuthRepository)
    : super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final CurrentAuthUserService _currentAuthUserService;
  final FirebaseAuthRepository _firebaseAuthRepository;

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _currentAuthUserService.init();
    if (_currentAuthUserService.isPresent()) {
      await _firebaseRefreshIdToken(emit);
    } else {
      _logout(emit);
    }
  }

  Future<void> _firebaseRefreshIdToken(
    Emitter<AuthenticationState> emit,
  ) async {
    String? firebaseIdToken = await _firebaseAuthRepository
        .refreshFirebaseIdToken();

    if (firebaseIdToken == null) {
      _currentAuthUserService.clearCurrentUser();
      emit(const AuthenticationState.unauthenticated());
    } else {
      _currentAuthUserService.setFirebaseIdToken(firebaseIdToken);
      emit(
        AuthenticationState.authenticated(
          _currentAuthUserService.isFirstAccess,
        ),
      );
    }
  }

  void _logout(Emitter<AuthenticationState> emit) {
    _firebaseAuthRepository.signOut();
    _currentAuthUserService.clearCurrentUser();
    emit(const AuthenticationState.unauthenticated());
  }

  void _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {
    _logout(emit);
  }
}
