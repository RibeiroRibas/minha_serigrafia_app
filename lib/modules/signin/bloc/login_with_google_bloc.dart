import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';

part 'login_with_google_event.dart';
part 'login_with_google_state.dart';

class LoginWithGoogleBloc
    extends Bloc<LoginWithGoogleEvent, LoginWithGoogleState> {
  LoginWithGoogleBloc(this._signInService)
    : super(const LoginWithGoogleState()) {
    on<LoginWithGoogleSubmitted>(_onSignInWithGoogleSubmitted);
  }

  final SignInService _signInService;

  Future<void> _onSignInWithGoogleSubmitted(
    LoginWithGoogleSubmitted event,
    Emitter<LoginWithGoogleState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      bool isFirstAccess = await _signInService.signInWithGoogle();
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          isFirstAccess: isFirstAccess,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
