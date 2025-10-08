import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/custom_auth_exception.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';

part 'login_with_google_state.dart';

class LoginWithGoogleCubit extends Cubit<LoginWithGoogleState> {
  LoginWithGoogleCubit(this._signInService)
    : super(const LoginWithGoogleState());

  final SignInService _signInService;

  Future<void> onSignInWithGoogleSubmitted() async {
    emit(state.withSubmissionInProgress());
    try {
      bool isFirstAccess = await _signInService.signInWithGoogle();
      emit(state.withSubmissionSuccess(isFirstAccess: isFirstAccess));
    } on CustomAuthException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (e) {
      emit(state.withSubmissionFailure());
    }
  }
}
