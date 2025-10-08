import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';
import 'package:minhaserigrafia/modules/signup/exceptions/email_in_use_exception.dart';
import 'package:minhaserigrafia/modules/signup/exceptions/sign_up_exception.dart';
import 'package:minhaserigrafia/modules/signup/repository/sign_up_repository.dart';
import 'package:minhaserigrafia/shared/model/cell_phone.dart';
import 'package:minhaserigrafia/shared/model/email.dart';
import 'package:minhaserigrafia/shared/model/password.dart';
import 'package:minhaserigrafia/shared/model/required_field.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpRepository, this._signInService)
    : super(const SignUpState());

  final SignUpRepository _signUpRepository;
  final SignInService _signInService;

  void onUserNameChanged(String userName) => emit(state.withUserName(userName));

  void onEmailChanged(String email) => emit(state.withEmail(email));

  void onCompanyNameChanged(String companyName) =>
      emit(state.withCompanyName(companyName));

  void onCellPhoneChanged(String cellPhone) =>
      emit(state.withCellPhone(cellPhone));

  void onPasswordChanged(String password) => emit(state.withPassword(password));

  void onConfirmPasswordChanged(String confirmPassword) =>
      emit(state.withConfirmPassword(confirmPassword));

  Future<void> onSignUpSubmitted() async {
    if (state.isStepTwoValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _signUpRepository.createAccount(
          userName: state.userName.value,
          companyName: state.companyName.value,
          cellPhone: state.cellPhone.value,
          email: state.email.value,
          password: state.password.value,
        );
        await _signInService.signInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.withSubmissionSuccess());
      } on EmailInUseException {
        emit(state.withSubmissionFailure(isEmailInUse: true));
      } on SignUpException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  Future<void> onCompleteSignUpSubmitted() async {
    if (state.isCompleteSignUpValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _signUpRepository.completeSignUp(
          companyName: state.companyName.value,
          cellPhone: state.cellPhone.value,
        );
        emit(state.withSubmissionSuccess());
      } on EmailInUseException {
        emit(state.withSubmissionFailure(isEmailInUse: true));
      } on SignUpException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }
}
