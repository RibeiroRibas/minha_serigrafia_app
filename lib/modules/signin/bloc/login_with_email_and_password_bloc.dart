import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/custom_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/firebase_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/model/email.dart';
import 'package:minhaserigrafia/modules/signin/model/password.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';

part 'login_email_and_password_event.dart';

part 'login_with_email_and_password_state.dart';

class LoginWithEmailAndPasswordBloc
    extends
        Bloc<LoginWithEmailAndPasswordEvent, LoginWithEmailAndPasswordState> {
  LoginWithEmailAndPasswordBloc(this._signInService)
    : super(const LoginWithEmailAndPasswordState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithEmailAndPasswordSubmitted>(_onSignInWithEmailSubmitted);
  }

  final SignInService _signInService;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginWithEmailAndPasswordState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginWithEmailAndPasswordState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.password]),
      ),
    );
  }

  Future<void> _onSignInWithEmailSubmitted(
    LoginWithEmailAndPasswordSubmitted event,
    Emitter<LoginWithEmailAndPasswordState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _signInService.signInWithEmailAndPassword(
          email: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on CustomFirebaseAuthException catch (e) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: e.message,
          ),
        );
      } on CustomAuthException catch (e) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorCode: e.code,
          ),
        );
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
