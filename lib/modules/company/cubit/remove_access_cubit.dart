import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/exceptions/company_exception.dart';
import 'package:minhaserigrafia/modules/company/repository/company_repository.dart';

part 'remove_access_state.dart';

class RemoveAccessCubit extends Cubit<RemoveAccessState> {
  RemoveAccessCubit(this._companyRepository) : super(const RemoveAccessState());

  final CompanyRepository _companyRepository;

  Future<void> onDeleteAccessSubmitted(int userId) async {
    emit(state.withSubmissionInProgress(deletingUserId: userId));
    try {
      await _companyRepository.deleteAccess(userId: userId);
      emit(state.withSubmissionSuccess());
    } on CompanyException catch (e) {
      emit(state.withSubmissionFailure(errorCode: e.code));
    } catch (_) {
      emit(state.withSubmissionFailure());
    }
  }
}
