import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/custom_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/firebase_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';
import 'package:minhaserigrafia/shared/model/email.dart';
import 'package:minhaserigrafia/shared/model/required_field.dart';

part 'login_with_email_and_password_state.dart';

class LoginWithEmailAndPasswordCubit
    extends Cubit<LoginWithEmailAndPasswordState> {
  LoginWithEmailAndPasswordCubit(this._signInService)
    : super(const LoginWithEmailAndPasswordState());

  final SignInService _signInService;

  void onEmailChanged(String email) => emit(state.withEmail(email));

  void onPasswordChanged(String password) =>
      emit(state.withPassword(password));

  Future<void> onSignInWithEmailSubmitted() async {
    if (!state.isValid) return;
    emit(state.withSubmissionInProgress());
    try {
      await _signInService.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.withSubmissionSuccess());
    } on CustomFirebaseAuthException catch (e) {
      emit(state.withSubmissionFailure(errorMessage: e.message));
    } on CustomAuthException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (e) {
      emit(state.withSubmissionFailure());
    }
  }
}
