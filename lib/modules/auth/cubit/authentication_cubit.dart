import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/signin/repository/custom_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
    this._currentAuthUserService,
    this._firebaseAuthRepository,
    this._customAuthRepository,
  ) : super(const AuthenticationState.unknown());

  final CurrentAuthUserService _currentAuthUserService;
  final FirebaseAuthRepository _firebaseAuthRepository;
  final CustomAuthRepository _customAuthRepository;

  Future<void> onSubscriptionRequested() async {
    await _currentAuthUserService.init();
    if (_currentAuthUserService.isPresent() &&
        _firebaseAuthRepository.firebaseAuth.currentUser != null) {
      await _tryRefreshUser();
    } else {
      _logout();
    }
  }

  Future<void> _tryRefreshUser() async {
    try {
      String? firebaseIdToken = await _firebaseAuthRepository
          .refreshFirebaseIdToken();
      if (firebaseIdToken == null) {
        _logout();
        return;
      }
      await _refreshUser(firebaseIdToken);
    } catch (e) {
      _logout();
    }
  }

  Future<void> _refreshUser(String firebaseIdToken) async {
    dynamic response = await _customAuthRepository.login(
      firebaseIdToken: firebaseIdToken,
    );
    _currentAuthUserService.setCurrentUserFromJson(
      response as Map<String, dynamic>,
    );
    _currentAuthUserService.setFirebaseIdToken(firebaseIdToken);
    emit(
      AuthenticationState.authenticated(_currentAuthUserService.isFirstAccess),
    );
  }

  void _logout() {
    _firebaseAuthRepository.signOut();
    _currentAuthUserService.clearCurrentUser();
    emit(const AuthenticationState.unauthenticated());
  }
}
