import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart' show UserCredential, FirebaseAuth;
import 'package:minhaserigrafia/modules/signin/exceptions/error_messages.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/firebase_auth_exception.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository()
    : _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Future<UserCredential> signInWithCredential({required String idToken}) async {
    try {
      final credential = firebase_auth.GoogleAuthProvider.credential(
        idToken: idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(
        'Falha ao tentar logar com o firebase signInWithCredential - ${e.code} - ${e.message}',
      );
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      String message = e.code == 'invalid-credential' || e.code == 'user-not-found'
          ? invalidFirebaseUserCredentials
          : 'Falha ao tentar logar com o firebase signInWithEmailAndPassword - ${e.code} - ${e.message}';
      throw CustomFirebaseAuthException(message);
    }
  }

  Future<String?> refreshFirebaseIdToken() async {
    try {
      await _firebaseAuth.currentUser?.reload();
      return await _firebaseAuth.currentUser!.getIdToken(true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw CustomFirebaseAuthException(
        'Falha ao tentar atualizar o usuário - ${e.code} - ${e.message}',
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw CustomFirebaseAuthException(
        'Falha ao tentar deslogar com o firebase signOut',
      );
    }
  }
}
