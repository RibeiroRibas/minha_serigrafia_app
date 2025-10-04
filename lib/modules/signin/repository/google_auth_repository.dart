import 'package:google_sign_in/google_sign_in.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/google_auth_exception.dart';

class GoogleAuthRepository {
  GoogleAuthRepository() : _googleSignIn = GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;

  Future<GoogleSignInAccount> logInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      return await _googleSignIn.authenticate();
    } catch (e) {
      throw GoogleAuthException(
        'Falha ao tentar logar com o Google authenticate - ${e.toString()}',
      );
    }
  }

  Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      throw GoogleAuthException(
        'Falha ao tentar deslogar com Google signOut- ${e.toString()}',
      );
    }
  }
}
