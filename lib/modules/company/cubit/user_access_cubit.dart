import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/exceptions/company_exception.dart';
import 'package:minhaserigrafia/modules/company/repository/company_repository.dart';
import 'package:minhaserigrafia/modules/signup/exceptions/email_in_use_exception.dart';
import 'package:minhaserigrafia/shared/model/email.dart';
import 'package:minhaserigrafia/shared/model/password.dart';
import 'package:minhaserigrafia/shared/model/required_field.dart';

part 'user_access_state.dart';

class UserAccessCubit extends Cubit<UserAccessState> {
  UserAccessCubit(this._companyRepository) : super(const UserAccessState());

  final CompanyRepository _companyRepository;

  void onUserNameChanged(String userName) => emit(state.withUserName(userName));

  void onEmailChanged(String email) => emit(state.withEmail(email));

  void onPasswordChanged(String password) => emit(state.withPassword(password));

  void onConfirmPasswordChanged(String confirmPassword) =>
      emit(state.withConfirmPassword(confirmPassword));

  Future<void> onCreateAccessSubmitted() async {
    if (state.isValid) {
      emit(state.withSubmissionInProgress());
      try {
        await _companyRepository.createAccess(
          userName: state.userName.value,
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.withSubmissionSuccess());
      } on EmailInUseException {
        emit(state.withSubmissionFailure(isEmailInUse: true));
      } on CompanyException catch (e) {
        emit(state.withSubmissionFailure(errorCode: e.code));
      } catch (_) {
        emit(state.withSubmissionFailure());
      }
    }
  }

  void resetState() {
    emit(state.reset());
  }
}
