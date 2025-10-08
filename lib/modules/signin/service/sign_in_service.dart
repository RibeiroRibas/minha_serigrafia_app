import 'package:firebase_auth/firebase_auth.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/custom_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/firebase_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/google_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/repository/custom_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/google_auth_repository.dart';

class SignInService {
  SignInService(
    this._customAuthRepository,
    this._firebaseAuthRepository,
    this._googleAuthRepository,
    this._currentAuthUserService,
  );

  final CustomAuthRepository _customAuthRepository;
  final FirebaseAuthRepository _firebaseAuthRepository;
  final GoogleAuthRepository _googleAuthRepository;
  final CurrentAuthUserService _currentAuthUserService;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuthRepository
          .signInWithEmailAndPassword(email: email, password: password);
      String? firebaseIdToken = await userCredential.user?.getIdToken();
      await _customAuthLogin(firebaseIdToken);
    } on CustomFirebaseAuthException {
      rethrow;
    } on CustomAuthException {
      rethrow;
    } catch (e) {
      throw Exception(
        'SignInService signInWithEmailAndPassword: ${e.toString()}',
      );
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await _googleAuthRepository.logInWithGoogle();
      String? idToken = googleUser.authentication.idToken;
      UserCredential userCredential = await _firebaseAuthRepository
          .signInWithCredential(idToken: idToken!);
      String? firebaseIdToken = await userCredential.user?.getIdToken();
      await _customAuthLogin(firebaseIdToken);
      return _currentAuthUserService.isFirstAccess;
    } on CustomFirebaseAuthException {
      rethrow;
    } on GoogleAuthException {
      rethrow;
    } on CustomAuthException {
      rethrow;
    } catch (e) {
      throw Exception('SignInService signInWithGoogle: ${e.toString()}');
    }
  }

  Future<void> _customAuthLogin(String? firebaseIdToken) async {
    dynamic response = await _customAuthRepository.login(
      firebaseIdToken: firebaseIdToken!,
    );
    _currentAuthUserService.setCurrentUserFromJson(
      response as Map<String, dynamic>,
    );
    _currentAuthUserService.setFirebaseIdToken(firebaseIdToken);
  }
}
